module Parser

export EmailAttachment,
    Email,
    parse_email

using Dates
using ..GMime

struct GMimeError <: Exception
    message::String
end

Base.show(io::IO, e::GMimeError) = print(io, e.message)

"""
    EmailAttachment

Email attachment.

## Fields
- `name::String`: File name.
- `encoding::String`: Attachment encoding type.
- `mime_type::String`: Attachment MIME type.
- `body::Vector{UInt8}`: Attachment binary data.
"""
struct EmailAttachment
    name::String
    encoding::String
    mime_type::String
    body::Vector{UInt8}
end

function Base.show(io::IO, a::EmailAttachment)
    println(io, "📎 Attachment:")
    println(io, "   📄 Name: $(a.name)")
    println(io, "   🛠️ Encoding: $(a.encoding)")
    println(io, "   🏷 Mime type: $(a.mime_type)")
    println(io, "   📏 Size: $(length(a.body)) bytes")
end

"""
    Email

Email structure with metadata and attachments.

## Fields
  - `from::Vector{String}`: Vector of the email sender(s) addresses.
  - `to::Vector{String}`: Vector of the email recipient(s) addresses.
  - `date::DateTime`: Date and time of the email sending.
  - `text_body::Vector{UInt8}`: Binary vector of the email text body.
  - `attachments::Vector{EmailAttachment}`: Vector of the email attachments with metadata.
"""
struct Email
    from::Vector{String}
    to::Vector{String}
    date::DateTime
    text_body::Vector{UInt8}
    attachments::Vector{EmailAttachment}
end

function Base.show(io::IO, m::Email)
    println(io, "📧 Email:")
    println(io, "   📤 From: $(join(m.from, ", "))")
    println(io, "   📥 To: $(join(m.to, ", "))")
    println(io, "   🕒 Date: $(m.date)")
    println(io, "   📝 Text size: $(length(m.text_body)) bytes")

    if !isempty(m.attachments)
        println(io, "   📎 Attachments:")
        for (i, a) in enumerate(m.attachments)
            println(io, "      $(i). $a")
        end
    else
        println(io, "   📨 No attachments.")
    end
end

function extract_addresses(msg::Ptr{GMimeMessage}, addr_type::GMimeAddressType)
    addr_list = g_mime_message_get_addresses(msg, addr_type)
    size = internet_address_list_length(addr_list)
    addrs = Vector{String}(undef, size)

    for i = 0:size-1
        addr = internet_address_list_get_address(addr_list, i)
        addrs[i+1] = unsafe_string(internet_address_to_string(addr, C_NULL, true))
    end

    return addrs
end

function extract_date(msg::Ptr{GMimeMessage})
    date = g_mime_message_get_date(msg)
    date_string = unsafe_string(g_date_time_format(date, "%Y-%m-%d %H:%M:%S"))
    return DateTime(date_string, DateFormat("yyyy-mm-dd HH:MM:SS"))
end

function read_text_data(part::Ptr{GMimeObject})
    content_ptr = g_mime_text_part_get_text(part)
    content = UInt8[]
    offset = 0
    while true
        byte = unsafe_load(content_ptr, offset + 1)
        push!(content, byte)
        byte == 0x00 && break
        offset += 1
    end
    return content
end

function handle_body(::Ptr{GMimeObject}, part::Ptr{GMimeObject}, user_data::Ptr{Vector{UInt8}})
    mime_type =  g_mime_object_get_content_type(part)

    # Skip every objects except email text body (text/plain)
    g_mime_content_type_is_type(mime_type, "text", "plain") || return nothing
    g_mime_part_is_attachment(part) && return nothing

    # Read text body data
    content = read_text_data(part)

    # Add text body
    append!(unsafe_pointer_to_objref(user_data), content)

    return nothing
end

function extract_text_body(msg::Ptr{GMimeMessage})
    text_body = UInt8[]
    callback = @cfunction(handle_body, Cvoid, (Ptr{GMimeObject}, Ptr{GMimeObject}, Ptr{Vector{UInt8}}))
    text_body_ptr = pointer_from_objref(text_body)
    g_mime_message_foreach(msg, callback, text_body_ptr)
    return text_body
end

function read_stream_data(stream::Ptr{GMimeStream}, buffer_size::Int64 = 4096)
    buffer = Vector{UInt8}(undef, buffer_size)
    content = UInt8[]
    while true
        bytes_read = g_mime_stream_read(stream, buffer, buffer_size)
        bytes_read <= 0 && break
        append!(content, buffer[1:bytes_read])
    end
    return content
end

function handle_attachment(::Ptr{GMimeObject}, part::Ptr{GMimeObject}, user_data::Ptr{Vector{EmailAttachment}})
    mime_type = g_mime_object_get_content_type(part)

    # Skip multipart objects and objects that are not attachments
    g_mime_content_type_is_type(mime_type, "multipart", "*") && return nothing
    g_mime_part_is_attachment(part) || return nothing

    # Extract metadata and attachment data
    filename = unsafe_string(g_mime_part_get_filename(part))

    content_wrapper = g_mime_part_get_content(part)
    content_wrapper == C_NULL && throw(GMimeError("Failed to get content for file: $filename."))

    stream = g_mime_data_wrapper_get_stream(content_wrapper)
    stream == C_NULL && throw(GMimeError("Failed to get stream for file: $filename."))

    # Apply content encoding filter
    encoding_type = g_mime_part_get_content_encoding(part)
    filter = g_mime_filter_basic_new(encoding_type, false)

    filtered_stream = g_mime_stream_filter_new(stream)
    filtered_stream == C_NULL && throw(GMimeError("Failed to apply filter for file: $filename."))

    # Read attachment data
    g_mime_stream_filter_add(filtered_stream, filter)
    attachment_data = read_stream_data(filtered_stream)

    # Add attachment to the list
    encoding_str = unsafe_string(g_mime_content_encoding_to_string(encoding_type))
    mime_type_str = unsafe_string(g_mime_content_type_get_mime_type(mime_type))
    attachments_list = unsafe_pointer_to_objref(user_data)
    push!(attachments_list, EmailAttachment(filename, encoding_str, mime_type_str, attachment_data))

    return nothing
end

function extract_attachments(msg::Ptr{GMimeMessage})
    attachments = EmailAttachment[]
    callback = @cfunction(handle_attachment, Cvoid, (Ptr{GMimeObject}, Ptr{GMimeObject}, Ptr{Vector{EmailAttachment}}))
    attachment_ptr = pointer_from_objref(attachments)
    g_mime_message_foreach(msg, callback, attachment_ptr)
    return attachments
end

function stream_init(data::AbstractVector{UInt8})
    stream = g_mime_stream_mem_new_with_buffer(pointer(data), length(data))
    stream == C_NULL && throw(GMimeError("Failed to create memory stream."))
    return stream
end

function parser_init(stream::Ptr{GMimeStream})
    parser = g_mime_parser_new_with_stream(stream)
    parser == C_NULL && throw(GMimeError("Failed to create parser."))
    g_mime_parser_set_format(parser, GMIME_FORMAT_MESSAGE)
    return parser
end

function parse_message(parser::Ptr{GMimeParser})
    message = g_mime_parser_construct_message(parser, C_NULL)
    message == C_NULL && throw(GMimeError("Failed to construct message."))
    return message
end

"""
    parse_email(data::Vector{UInt8}) -> Email
    parse_email(data::String) -> Email

Parse a binary vector or string `data` into a [Email](@ref).

## Example

```julia
julia> email_string = \"\"\"
       MIME-Version: 1.0
       Date: Tue, 5 Mar 1996 11:00:00 +0300
       Message-ID: <CAOU+8LMfxVaPMmigMQE2qTBLSbNdKQVps=Fi0S3X8LnfxT2xee@mail.email.com>
       Subject: Test Message
       From: Test User <username@example.com>
       To: Test User <username@example.com>
       Content-Type: multipart/alternative; boundary="000000000000dd23a50621ff39e8"
       
       --000000000000dd23a50621ff39e8
       Content-Type: text/plain; charset="UTF-8"
       
       Hello World!
       
       Best regards,
       Test User
       
       --000000000000dd23a50621ff39e8
       Content-Type: text/html; charset="UTF-8"
       
       <div dir="ltr">Hello World!<div><br></div><div>Best regards,</div><div>Test User</div></div>
       
       --000000000000dd23a50621ff39e8--
       \"\"\";

julia> email = parse_email(email_string)
📧 Email:
   📤 From: Test User <username@example.com>
   📥 To: Test User <username@example.com>
   🕒 Date: 1996-03-05T11:00:00
   📝 Text size: 39 bytes
   📨 No attachments.
```
"""
function parse_email(data::AbstractVector{UInt8})
    stream = stream_init(data)
    parser = parser_init(stream)
    g_object_unref(stream)
    message = parse_message(parser)
    g_object_unref(parser)
    email = Email(
        extract_addresses(message, GMIME_ADDRESS_TYPE_FROM),
        extract_addresses(message, GMIME_ADDRESS_TYPE_TO),
        extract_date(message),
        extract_text_body(message),
        extract_attachments(message)
    )
    g_object_unref(message)
    return email
end

function parse_email(data::AbstractString)
    return parse_email(codeunits(data))
end

end
