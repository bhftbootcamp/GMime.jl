module GMime

export GMIME_MAJOR_VERSION,
    GMIME_MINOR_VERSION,
    GMIME_MICRO_VERSION,
    GMIME_BINARY_AGE,
    GMIME_INTERFACE_AGE

export GMimeSeekWhence,
    GMIME_STREAM_SEEK_SET,
    GMIME_STREAM_SEEK_CUR,
    GMIME_STREAM_SEEK_END

export GMimeFormat,
    GMIME_FORMAT_MESSAGE,
    GMIME_FORMAT_MBOX,
    GMIME_FORMAT_MMDF

export GMimeAddressType,
    GMIME_ADDRESS_TYPE_SENDER,
    GMIME_ADDRESS_TYPE_FROM,
    GMIME_ADDRESS_TYPE_REPLY_TO,
    GMIME_ADDRESS_TYPE_TO,
    GMIME_ADDRESS_TYPE_CC,
    GMIME_ADDRESS_TYPE_BCC

export GMimeStream,
    GMimeStreamMem,
    GMimeStreamFilter,
    GMimeParser,
    GMimeObject,
    GMimeMessage,
    GMimeMessagePart,
    GMimePart,
    GMimeContentType,
    GMimeDataWrapper,
    GMimeFilter

export InternetAddressList,
    InternetAddress

export g_mime_init,
    g_mime_shutdown,
    gmime_check_version

export g_mime_stream_construct,
    g_mime_stream_read,
    g_mime_stream_write,
    g_mime_stream_flush,
    g_mime_stream_seek,
    g_mime_stream_tell,
    g_mime_stream_reset,
    g_mime_stream_eos,
    g_mime_stream_close,
    g_mime_stream_length,
    g_mime_stream_substream,
    g_mime_stream_set_bounds,
    g_mime_stream_write_string,
    g_mime_stream_printf,
    g_mime_stream_write_to_stream

export g_mime_stream_mem_new,
    g_mime_stream_mem_new_with_byte_array,
    g_mime_stream_mem_new_with_buffer,
    g_mime_stream_mem_get_byte_array,
    g_mime_stream_mem_set_byte_array,
    g_mime_stream_mem_get_owner,
    g_mime_stream_mem_set_owner

export g_mime_stream_filter_new,
    g_mime_stream_filter_add

export g_mime_parser_new,
    g_mime_parser_new_with_stream,
    g_mime_parser_init_with_stream,
    g_mime_parser_get_persist_stream,
    g_mime_parser_set_persist_stream,
    g_mime_parser_get_format,
    g_mime_parser_set_format,
    g_mime_parser_get_respect_content_length,
    g_mime_parser_set_respect_content_length,
    g_mime_parser_tell,
    g_mime_parser_eos,
    g_mime_parser_construct_part,
    g_mime_parser_construct_message

export g_mime_object_get_header,
    g_mime_object_get_header_list,
    g_mime_object_get_content_type,
    g_mime_object_to_string

export g_mime_content_type_get_mime_type,
    g_mime_content_type_is_type,
    g_mime_content_type_get_parameter

export g_mime_message_new,
    g_mime_message_get_sender,
    g_mime_message_get_from,
    g_mime_message_get_reply_to,
    g_mime_message_get_to,
    g_mime_message_get_cc,
    g_mime_message_get_bcc,
    g_mime_message_add_mailbox,
    g_mime_message_get_addresses,
    g_mime_message_get_all_recipients,
    g_mime_message_set_subject,
    g_mime_message_get_subject,
    g_mime_message_set_date,
    g_mime_message_get_date,
    g_mime_message_set_message_id,
    g_mime_message_get_message_id,
    g_mime_message_set_mime_part,
    g_mime_message_get_mime_part,
    g_mime_message_foreach,
    g_mime_message_get_body

export g_mime_message_part_get_message

export internet_address_list_length,
    internet_address_list_get_address

export internet_address_get_name,
    internet_address_get_charset,
    internet_address_to_string

export g_mime_header_list_get_count,
    g_mime_header_list_get_header_at,
    g_mime_header_get_name,
    g_mime_header_get_value

export g_mime_part_is_attachment,
    g_mime_part_get_filename,
    g_mime_part_get_content,
    g_mime_part_get_content_encoding

export g_mime_text_part_get_text

export g_mime_data_wrapper_get_stream

export g_mime_filter_basic_new

export g_mime_content_encoding_to_string

export g_object_unref,
    g_date_time_format,
    g_free

export EmailAttachment,
    Email,
    parse_email

using gmime_jll

const GMIME_MAJOR_VERSION = 0x00000003 # 3U
const GMIME_MINOR_VERSION = 0x00000002 # 2U
const GMIME_MICRO_VERSION = 0x0000000f # 15U
const GMIME_BINARY_AGE    = 0x000000d7 # 215U
const GMIME_INTERFACE_AGE = 0x00000001 # 1U

const GMimeSeekWhence = Int32
const GMIME_STREAM_SEEK_SET = GMimeSeekWhence(0)
const GMIME_STREAM_SEEK_CUR = GMimeSeekWhence(1)
const GMIME_STREAM_SEEK_END = GMimeSeekWhence(2)

const GMimeFormat = Int32
const GMIME_FORMAT_MESSAGE = GMimeFormat(0)
const GMIME_FORMAT_MBOX    = GMimeFormat(1)
const GMIME_FORMAT_MMDF    = GMimeFormat(2)

const GMimeAddressType = Int32
const GMIME_ADDRESS_TYPE_SENDER   = GMimeAddressType(0)
const GMIME_ADDRESS_TYPE_FROM     = GMimeAddressType(1)
const GMIME_ADDRESS_TYPE_REPLY_TO = GMimeAddressType(2)
const GMIME_ADDRESS_TYPE_TO       = GMimeAddressType(3)
const GMIME_ADDRESS_TYPE_CC       = GMimeAddressType(4)
const GMIME_ADDRESS_TYPE_BCC      = GMimeAddressType(5)

struct GError
    domain::Ptr{Cchar}
    code::Cint
    message::Ptr{Cchar}
end

struct GDateTime end
abstract type GObject end

struct GMimeParserOptions end
struct GMimeStream          <: GObject end
struct GMimeStreamMem       <: GObject end
struct GMimeStreamFilter    <: GObject end
struct GMimeParser          <: GObject end
struct GMimeObject          <: GObject end
struct GMimeContentType     <: GObject end
struct GMimeMessage         <: GObject end
struct GMimeMessagePart     <: GObject end
struct InternetAddressList  <: GObject end
struct InternetAddress      <: GObject end
struct GMimeFormatOptions   <: GObject end
struct GMimeHeaderList      <: GObject end
struct GMimeHeader          <: GObject end
struct GMimePart            <: GObject end
struct GMimeContentEncoding <: GObject end
struct GMimeDataWrapper     <: GObject end
struct GMimeFilter          <: GObject end

function __init__()
    g_mime_init()
    atexit(g_mime_shutdown)
end

function g_mime_init()
    return ccall((:g_mime_init, libgmime), Cvoid, ())
end

function g_mime_shutdown()
    return ccall((:g_mime_shutdown, libgmime), Cvoid, ())
end

function gmime_check_version(major, minor, micro)
    return ccall((:g_mime_check_version, libgmime), Cint, (UInt32, UInt32, UInt32), major, minor, micro)
end

#__ GMimeStream

function g_mime_stream_construct(stream, start, final)
    return ccall((:g_mime_stream_construct, libgmime), Cvoid, (Ptr{GMimeStream}, Int64, Int64), stream, start, final)
end

function g_mime_stream_read(stream, buf, len)
    return ccall((:g_mime_stream_read, libgmime), Csize_t, (Ptr{GMimeStream}, Ptr{Cchar}, Csize_t), stream, buf, len)
end

function g_mime_stream_write(stream, buf, len)
    return ccall((:g_mime_stream_write, libgmime), Csize_t, (Ptr{GMimeStream}, Ptr{Cchar}, Csize_t), stream, buf, len)
end

function g_mime_stream_flush(stream)
    return ccall((:g_mime_stream_flush, libgmime), Cint, (Ptr{GMimeStream},), stream)
end

function g_mime_stream_seek(stream, offset, whence)
    return ccall((:g_mime_stream_seek, libgmime), Int64, (Ptr{GMimeStream}, Int64, Int32), stream, offset, whence)
end

function g_mime_stream_tell(stream)
    return ccall((:g_mime_stream_tell, libgmime), Int64, (Ptr{GMimeStream},), stream)
end

function g_mime_stream_reset(stream)
    return ccall((:g_mime_stream_reset, libgmime), Int64, (Ptr{GMimeStream},), stream)
end

function g_mime_stream_eos(stream)
    return ccall((:g_mime_stream_eos, libgmime), Bool, (Ptr{GMimeStream},), stream)
end

function g_mime_stream_close(stream)
    return ccall((:g_mime_stream_close, libgmime), Int64, (Ptr{GMimeStream},), stream)
end

function g_mime_stream_length(stream)
    return ccall((:g_mime_stream_length, libgmime), Int64, (Ptr{GMimeStream},), stream)
end

function g_mime_stream_substream(stream, start, final)
    return ccall((:g_mime_stream_substream, libgmime), Ptr{GMimeStream}, (Ptr{GMimeStream}, Int64, Int64), stream, start, final)
end

function g_mime_stream_set_bounds(stream, start, final)
    return ccall((:g_mime_stream_set_bounds, libgmime), Cvoid, (Ptr{GMimeStream}, Int64, Int64), stream, start, final)
end

function g_mime_stream_write_string(stream, str)
    return ccall((:g_mime_stream_write_string, libgmime), Csize_t, (Ptr{GMimeStream}, Ptr{UInt8}), stream, str)
end

function g_mime_stream_printf(stream, fmt, args...)
    return  ccall((:g_mime_stream_printf, libgmime), Csize_t, (Ptr{GMimeStream}, Ptr{UInt8}), stream, fmt)
end

function g_mime_stream_write_to_stream(src, dest)
    return ccall((:g_mime_stream_write_to_stream, libgmime), Int64, (Ptr{GMimeStream}, Ptr{GMimeStream}), src, dest)
end

#__ GMimeStreamMem

function g_mime_stream_mem_new()
    return ccall((:g_mime_stream_mem_new, libgmime), Ptr{GMimeStream}, ())
end

function g_mime_stream_mem_new_with_byte_array(array)
    return ccall((:g_mime_stream_mem_new_with_byte_array, libgmime), Ptr{GMimeStream}, (Ptr{UInt8},), array)
end

function g_mime_stream_mem_new_with_buffer(buffer, len)
    return ccall((:g_mime_stream_mem_new_with_buffer, libgmime), Ptr{GMimeStream}, (Ptr{UInt8}, Csize_t), buffer, len)
end

function g_mime_stream_mem_get_byte_array(mem)
    return ccall((:g_mime_stream_mem_get_byte_array, libgmime), Ptr{Vector{UInt8}}, (Ptr{GMimeStreamMem},), mem)
end

function g_mime_stream_mem_set_byte_array(mem, array)
    return ccall((:g_mime_stream_mem_set_byte_array, libgmime), Cvoid, (Ptr{GMimeStreamMem}, Ptr{Vector{UInt8}}), mem, array)
end

function g_mime_stream_mem_get_owner(mem)
    return ccall((:g_mime_stream_mem_get_owner, libgmime), Bool, (Ptr{GMimeStreamMem},), mem)
end

function g_mime_stream_mem_set_owner(mem, owner)
    return ccall((:g_mime_stream_mem_set_owner, libgmime), Cvoid, (Ptr{GMimeStreamMem}, Bool), mem, owner)
end

#__ GMimeStreamFilter

function g_mime_stream_filter_new(stream)
    return ccall((:g_mime_stream_filter_new, libgmime), Ptr{GMimeStream}, (Ptr{GMimeStream},), stream)
end

function g_mime_stream_filter_add(stream, filter)
    return ccall((:g_mime_stream_filter_add, libgmime), Int, (Ptr{GMimeStreamFilter}, Ptr{GMimeFilter}), stream, filter)
end

#__ Parser

# TODO: Add GMimeParserHeaderRegexFunc function signature for callback

function GMimeParserHeaderRegexFunc end

function g_mime_parser_new()
    return ccall((:g_mime_parser_new, libgmime), Ptr{GMimeParser}, ())
end

function g_mime_parser_new_with_stream(stream)
    return ccall((:g_mime_parser_new_with_stream, libgmime), Ptr{GMimeParser}, (Ptr{GMimeStream},), stream)
end

function g_mime_parser_init_with_stream(parser, stream)
    return ccall((:g_mime_parser_init_with_stream, libgmime), Cvoid, (Ptr{GMimeParser}, Ptr{GMimeStream}), parser, stream)
end

function g_mime_parser_get_persist_stream(parser)
    return ccall((:g_mime_parser_get_persist_stream, libgmime), Bool, (Ptr{GMimeParser},), parser)
end

function g_mime_parser_set_persist_stream(parser, persist)
    return ccall((:g_mime_parser_set_persist_stream, libgmime), Cvoid, (Ptr{GMimeParser}, Bool), parser, persist)
end

function g_mime_parser_get_format(parser)
    return ccall((:g_mime_parser_get_format, libgmime), GMimeFormat, (Ptr{GMimeParser},), parser)
end

function g_mime_parser_set_format(parser, format::GMimeFormat)
    return ccall((:g_mime_parser_set_format, libgmime), Cvoid, (Ptr{GMimeParser}, Int32), parser, format)
end

function g_mime_parser_get_respect_content_length(parser)
    return ccall((:g_mime_parser_get_respect_content_length, libgmime), Bool, (Ptr{GMimeParser},), parser)
end

function g_mime_parser_set_respect_content_length(parser, respect_content_length)
    return ccall((:g_mime_parser_set_respect_content_length, libgmime), Cvoid, (Ptr{GMimeParser}, Bool), parser, respect_content_length)
end

# TODO: Add g_mime_parser_set_header_regex method

function g_mime_parser_set_header_regex end

function g_mime_parser_tell(parser)
    return ccall((:g_mime_parser_tell, libgmime), Int64, (Ptr{GMimeParser}, ), parser)
end

function g_mime_parser_eos(parser)
    return ccall((:g_mime_parser_eos, libgmime), Bool, (Ptr{GMimeParser},), parser)
end

function g_mime_parser_construct_part(parser, options)
    return ccall((:g_mime_parser_construct_part, libgmime), Ptr{GMimeObject}, (Ptr{GMimeParser}, Ptr{GMimeParserOptions}), parser, options)
end

function g_mime_parser_construct_message(parser, options)
    return ccall((:g_mime_parser_construct_message, libgmime), Ptr{GMimeMessage}, (Ptr{GMimeParser}, Ptr{GMimeParserOptions}), parser, options)
end

# TODO: Add other parser intefraces

#__ GMimeObject

function g_mime_object_get_header(object, header)
    return ccall((:g_mime_object_get_header, libgmime), Ptr{UInt8}, (Ptr{GMimeObject}, Ptr{UInt8}), object, header)
end

function g_mime_object_get_header_list(object)
    return ccall((:g_mime_object_get_header_list, libgmime), Ptr{GMimeHeaderList}, (Ptr{GMimeObject},), object)
end

function g_mime_object_get_content_type(object)
    return ccall((:g_mime_object_get_content_type, libgmime), Ptr{GMimeContentType}, (Ptr{GMimeObject},), object)
end

function g_mime_object_to_string(object, options)
    return ccall((:g_mime_object_to_string, GMime.gmime_jll.libgmime), Ptr{UInt8}, (Ptr{GMimeObject}, Ptr{GMimeFormatOptions}), object, options)
end

# TODO: Add other object intefraces

#__ GMimeContentType

function g_mime_content_type_get_mime_type(content_type)
    return ccall((:g_mime_content_type_get_mime_type, libgmime), Ptr{UInt8}, (Ptr{GMimeContentType},), content_type)
end

function g_mime_content_type_is_type(content_type, type, subtype)
    return ccall((:g_mime_content_type_is_type, libgmime), Bool, (Ptr{GMimeContentType}, Ptr{UInt8}, Ptr{UInt8}), content_type, type, subtype)
end

function g_mime_content_type_get_parameter(content_type, name)
    return ccall((:g_mime_content_type_get_parameter, libgmime), Ptr{UInt8}, (Ptr{GMimeContentType}, Ptr{UInt8}), content_type, name)
end

#__ GMimeMessage

function g_mime_message_new(pretty_headers)
    return ccall((:g_mime_message_new, libgmime), Ptr{GMimeMessage}, (Bool,), pretty_headers)
end

function g_mime_message_get_sender(message)
    return ccall((:g_mime_message_get_sender, libgmime), Ptr{InternetAddressList}, (Ptr{GMimeMessage},), message)
end

function g_mime_message_get_from(message)
    return ccall((:g_mime_message_get_from, libgmime), Ptr{InternetAddressList}, (Ptr{GMimeMessage},), message)
end

function g_mime_message_get_reply_to(message)
    return ccall((:g_mime_message_get_reply_to, libgmime), Ptr{InternetAddressList}, (Ptr{GMimeMessage},), message)
end

function g_mime_message_get_to(message)
    return ccall((:g_mime_message_get_to, libgmime), Ptr{InternetAddressList}, (Ptr{GMimeMessage},), message)
end

function g_mime_message_get_cc(message)
    return ccall((:g_mime_message_get_cc, libgmime), Ptr{InternetAddressList}, (Ptr{GMimeMessage},), message)
end

function g_mime_message_get_bcc(message)
    return ccall((:g_mime_message_get_bcc, libgmime), Ptr{InternetAddressList}, (Ptr{GMimeMessage},), message)
end

function g_mime_message_add_mailbox(message, type, name, addr)
    return ccall((:g_mime_message_add_mailbox, libgmime), Cvoid, (Ptr{GMimeMessage}, GMimeAddressType, Ptr{UInt8}, Ptr{UInt8}), message, type, name, addr)
end

function g_mime_message_get_addresses(message, type)
    return ccall((:g_mime_message_get_addresses, libgmime), Ptr{InternetAddressList}, (Ptr{GMimeMessage}, Int32), message, type)
end

function g_mime_message_get_all_recipients(message)
    return ccall((:g_mime_message_get_all_recipients, libgmime), Ptr{InternetAddressList}, (Ptr{GMimeMessage},), message)
end

function g_mime_message_set_subject(message, subject, charset)
    return ccall((:g_mime_message_set_subject, libgmime), Cvoid, (Ptr{GMimeMessage}, Ptr{UInt8}, Ptr{UInt8}), message, subject, charset)
end

function g_mime_message_get_subject(message)
    return ccall((:g_mime_message_get_subject, libgmime), Ptr{UInt8}, (Ptr{GMimeMessage},), message)
end

function g_mime_message_set_date(message, date)
    return ccall((:g_mime_message_set_date, libgmime), Cvoid, (Ptr{GMimeMessage}, Ptr{Cvoid}), message, date)
end

function g_mime_message_get_date(message)
    return ccall((:g_mime_message_get_date, libgmime), Ptr{GDateTime}, (Ptr{GMimeMessage},), message)
end

function g_mime_message_set_message_id(message, message_id)
    return ccall((:g_mime_message_set_message_id, libgmime), Cvoid, (Ptr{GMimeMessage}, Ptr{UInt8}), message, message_id)
end

function g_mime_message_get_message_id(message)
    return ccall((:g_mime_message_get_message_id, libgmime), Ptr{UInt8}, (Ptr{GMimeMessage},), message)
end

function g_mime_message_set_mime_part(message, mime_part)
    return ccall((:g_mime_message_set_mime_part, libgmime), Cvoid, (Ptr{GMimeMessage}, Ptr{GMimeObject}), message, mime_part)
end

function g_mime_message_get_mime_part(message)
    return ccall((:g_mime_message_get_mime_part, libgmime), Ptr{GMimeObject}, (Ptr{GMimeMessage},), message)
end

function g_mime_message_foreach(message, callback, user_data)
    return ccall((:g_mime_message_foreach, libgmime), Cvoid, (Ptr{GMimeMessage}, Ptr{Cvoid}, Ptr{Cvoid}), message, callback, user_data)
end

function GMimeObjectForeachFunc(user_function, ::T) where {T}
    return @cfunction($user_function, Cvoid, (Ptr{GMimeObject}, Ptr{GMimeObject}, Ptr{T}))
end

function g_mime_message_get_body(message)
    return ccall((:g_mime_message_get_body, libgmime), Ptr{GMimeObject}, (Ptr{GMimeMessage},), message)
end

# TODO: Add other message intefraces

#__ GMimeMessagePart

function g_mime_message_part_get_message(part)
    return ccall((:g_mime_message_part_get_message, libgmime), Ptr{GMimeMessage}, (Ptr{GMimeMessagePart},), part)
end

#__ InternetAddressList

function internet_address_list_length(list)
    return ccall((:internet_address_list_length, libgmime), Int64, (Ptr{InternetAddressList},), list)
end

function internet_address_list_get_address(list, index)
    return ccall((:internet_address_list_get_address, libgmime), Ptr{InternetAddress}, (Ptr{InternetAddressList}, Int), list, index)
end

# TODO: Add other internet addres list intefraces

#__ InternetAddress

function internet_address_get_name(ia)
    return ccall((:internet_address_get_name, libgmime), Ptr{UInt8}, (Ptr{InternetAddress},), ia)
end

function internet_address_get_charset(ia)
    return ccall((:internet_address_get_charset, libgmime), Ptr{UInt8}, (Ptr{InternetAddress},), ia)
end

function internet_address_to_string(ia, options, encode)
    return ccall((:internet_address_to_string, libgmime), Ptr{UInt8}, (Ptr{InternetAddress}, Ptr{GMimeFormatOptions}, Bool), ia, options, encode)
end

# TODO: Add other internet adress intefraces

#__ GMimeHeaderList

function g_mime_header_list_get_count(headers)
    return ccall((:g_mime_header_list_get_count, libgmime), Int, (Ptr{GMimeHeaderList},), headers)
end

function g_mime_header_list_get_header_at(headers, index)
    return ccall((:g_mime_header_list_get_header_at, libgmime), Ptr{GMimeHeader}, (Ptr{GMimeHeaderList}, Int), headers, index)
end

function g_mime_header_get_name(header)
    return ccall((:g_mime_header_get_name, libgmime), Ptr{UInt8}, (Ptr{GMimeHeader},), header)
end

function g_mime_header_get_value(header)
    return ccall((:g_mime_header_get_value, libgmime), Ptr{UInt8}, (Ptr{GMimeHeader},), header)
end

# TODO: Add other header list intefraces

#__ GMimePart

function g_mime_part_is_attachment(mime_part)
    return ccall((:g_mime_part_is_attachment, libgmime), Bool, (Ptr{GMimePart},), mime_part)
end

function g_mime_part_get_filename(mime_part)
    return ccall((:g_mime_part_get_filename, libgmime), Ptr{UInt8}, (Ptr{GMimePart},), mime_part)
end

function g_mime_part_get_content(mime_part)
    return ccall((:g_mime_part_get_content, libgmime), Ptr{GMimeDataWrapper}, (Ptr{GMimePart},), mime_part)
end

function g_mime_part_get_content_encoding(mime_part)
    return ccall((:g_mime_part_get_content_encoding, libgmime), Ptr{GMimeContentEncoding}, (Ptr{GMimePart},), mime_part)
end

#__ GMimeTextPart

function g_mime_text_part_get_text(mime_part)
    return ccall((:g_mime_text_part_get_text, libgmime), Ptr{UInt8}, (Ptr{GMimePart},), mime_part)
end

#__ GMimeDataWrapper

function g_mime_data_wrapper_get_stream(wrapper)
    return ccall((:g_mime_data_wrapper_get_stream, libgmime), Ptr{GMimeStream}, (Ptr{GMimeDataWrapper},), wrapper)
end

#__ GMimeFilterBasic

function g_mime_filter_basic_new(encoding, encode)
    return ccall((:g_mime_filter_basic_new, libgmime), Ptr{GMimeFilter}, (Ptr{GMimeContentEncoding}, Bool), encoding, encode)
end

#__ GMimeEncodings

function g_mime_content_encoding_to_string(encoding)
    return ccall((:g_mime_content_encoding_to_string, libgmime), Ptr{UInt8}, (Ptr{GMimeContentEncoding},), encoding)
end

#__ Glib

function g_object_unref(object)
    return ccall((:g_object_unref, libgmime), Cvoid, (Ptr{GObject},), object)
end

function g_date_time_format(datetime, format)
    return ccall((:g_date_time_format, libgmime), Ptr{UInt8}, (Ptr{GDateTime}, Ptr{UInt8}), datetime, format)
end

function g_free(ptr)
    return ccall((:g_free,  libgmime), Cvoid, (Ptr{Cvoid},), ptr)
end

include("Parser.jl")
using .Parser

end
