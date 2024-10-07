using GMime
using Documenter

DocMeta.setdocmeta!(GMime, :DocTestSetup, :(using GMime); recursive = true)

makedocs(;
    modules = [GMime],
    sitename = "GMime.jl",
    format = Documenter.HTML(;
        repolink = "https://github.com/bhftbootcamp/GMime.jl",
        canonical = "https://bhftbootcamp.github.io/GMime.jl",
        edit_link = "master",
        assets = ["assets/favicon.ico"],
        sidebar_sitename = true,  # Set to 'false' if the package logo already contain its name
    ),
    pages = [
        "Home"    => "index.md",
        "pages/api_reference.md",
    ],
    warnonly = [:doctest, :missing_docs],
)

deploydocs(;
    repo = "github.com/bhftbootcamp/GMime.jl",
    devbranch = "master",
    push_preview = true,
)
