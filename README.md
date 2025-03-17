# GMime.jl

[![Stable](https://img.shields.io/badge/docs-stable-blue.svg)](https://bhftbootcamp.github.io/GMime.jl/stable/)
[![Dev](https://img.shields.io/badge/docs-dev-blue.svg)](https://bhftbootcamp.github.io/GMime.jl/dev/)
[![Build Status](https://github.com/bhftbootcamp/GMime.jl/actions/workflows/CI.yml/badge.svg?branch=master)](https://github.com/bhftbootcamp/GMime.jl/actions/workflows/CI.yml?query=branch%3Amaster)
[![Coverage](https://codecov.io/gh/bhftbootcamp/GMime.jl/branch/master/graph/badge.svg)](https://codecov.io/gh/bhftbootcamp/GMime.jl)
[![Registry](https://img.shields.io/badge/registry-General-4063d8)](https://github.com/JuliaRegistries/General)

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

## Contributing

Contributions to GMime are welcome! If you encounter a bug, have a feature request, or would like to contribute code, please open an issue or a pull request on GitHub.
