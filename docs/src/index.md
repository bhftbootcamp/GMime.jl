# GMime.jl

GMime is a convenient wrapper around the [GMime](https://github.com/jstedfast/gmime) library for parsing email messages in Julia. It can extract sender, recipient, date, body text, attachments and other email information.

## Installation

To install GMime, simply use the Julia package manager:

```julia
] add Gmime
```

## Usage

Here's a small example of how to parse content from an email body:

```julia
using GMime
using EasyCurl

# Fetch the email data from an IMAP server
response = imap_request(
    "imaps://imap.gmail.com:993",
    get(ENV, "IMAP_USER", ""),
    get(ENV, "IMAP_PASSWORD", ""),
    mailbox = "INBOX",
    path = "MAILINDEX=993"
)

# Extract the raw email body
data = imap_body(response)

# Parse the email using GMime
julia> email = parse_email(data)
📧 Email:
   📤 From: Broker Support <support@broker.com>
   📥 To: Portfolio Manager <pm@hedgefund.com>
   🕒 Date: 2024-08-06T17:34:04
   📎 Attachments:
      1. 📎 Attachment:
   📄 Name: CashFlowReport_Q3_2024.pdf
   🛠️ Encoding: base64
   🏷 Mime type: application/pdf
   📏 Size: 18000 bytes

      2. 📎 Attachment:
   📄 Name: ClosedPositions_Summary_2024-08-06.csv
   🛠️ Encoding: base64
   🏷 Mime type: text/csv
   📏 Size: 250000 bytes

      3. 📎 Attachment:
   📄 Name: DailyTransaction_2024-08-06.csv
   🛠️ Encoding: base64
   🏷 Mime type: text/csv
   📏 Size: 12800 bytes
```

## Useful Links

- [gmime](https://github.com/jstedfast/gmime) – Official library repository.  
- [gmime_jll.jl](https://github.com/JuliaBinaryWrappers/gmime_jll.jl) – Julia wrapper for gmime.  
- Enable IMAP support in your email provider’s settings. See this [Gmail guide](https://support.getmailbird.com/hc/en-us/articles/220106527-Enabling-IMAP-for-Gmail).  
- Generate an app-specific password for your email account. See details [here](https://support.google.com/accounts/answer/185833?hl=en).  
