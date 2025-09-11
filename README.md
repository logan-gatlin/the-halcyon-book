# Build
Install mdbook and the preprocessors we need
```bash
cargo install mdbook
cargo install mdbook-admonish
cargo install mdbook-treesitter
```
Then build the project using `mdbook build`, or see a live preview using `mdbook serve`.

# Syntax highlighting
Syntax highlighting is done using the [tree-sitter-halcyon](https://git.lgatlin.dev/logan/tree-sitter-halcyon) grammar.
The [treesitter/halcyon.so](./treesitter/halcyon.so) will need to be manually updated when the language's grammar changes.
To build the grammar, first install `tree-sitter-cli`:
```bash
cargo install tree-sitter-cli
```
Next, in the `tree-sitter-halcyon` project directory, run:
```bash
# The preprocessor requires an older ABI version
tree-sitter-cli generate --abi 14
tree-sitter-cli build
```
and copy `halcyon.so` to the [treesitter/](./treesitter/) directory of this book.

# Performance
The `mdbook-treesitter` preprocessor makes the live preview very slow.
To see results more quickly, comment out the following lines in [book.toml](./book.toml):
```toml
[output.html]
#additional-js = ["./assets/treesitter.js"]

#[preprocessor.treesitter]
#command = "mdbook-treesitter"
#languages = ["halcyon"]
```
Don't forget to uncomment these lines before committing!
