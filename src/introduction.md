# Introduction
Welcome to **The Halcyon Book**, the official documentation for the Halcyon programming language.
Halcyon is a compiled, strongly typed, functional programming language.
It is compiled to [WebAssembly](https://webassembly.org/), a portable binary format that can run in the browser.

## Getting Started
You can try out Halcyon in your browser using the [online compiler](https://try.halcyon-lang.dev/).
If the online compiler is having issues, make sure your browser is fully up to date.
The Halcyon compiler is also available as a standalone executable called `hcc`.
To download it, go to the [releases page](https://github.com/LoganLeeTwentyThree/hcc/releases/tag/v0.1.0), and pick the correct file for your operating system.

## IDE Setup

### Visual Studio Code
*TODO*

### Helix
In your Helix config folder (`~/.config/helix/` by default), create `languages.toml` if it does not already exist.
Add a grammar and language entry for Halcyon:
```toml
[[grammar]]
name = "halcyon"
source = { git = "https://git.lgatlin.dev/logan/tree-sitter-halcyon.git", rev = "main" }

[[language]]
name = "halcyon"
scope = "source.hc"
file-types = ["hc"]
grammar = "halcyon"
comment-tokens = ["--"]
block-comment-tokens = { start = "(*", end = "*)" }
```
Next, fetch and build the grammar.
If this is your first time building grammars this will take several minutes.
```bash
helix -g fetch
helix -g build
```
Finally, download the highlight queries to your runtime directory:
```bash
mkdir -p ~/.config/helix/runtime/queries/halcyon
wget https://git.lgatlin.dev/logan/tree-sitter-halcyon/raw/branch/main/queries/highlights.scm \
  -O ~/.config/helix/runtime/queries/halcyon/highlights.scm
```

### Hello World
Time to write your first Halcyon program.
Try compiling and executing this minimal program:
```halcyon
module hello_world =
  do std::println "Hello World!"
end
```
