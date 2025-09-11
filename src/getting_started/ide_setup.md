# IDE Setup

## Visual Studio Code
**TODO**

## Helix
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
