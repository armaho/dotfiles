# External Dependencies

## Mason

- `lua-language-server`
- `tree-sitter-cli`
- `clangd`
- `cmake-language-server`
- `gopls`
- `typescript-language-server`
- `pyright`
- `marksman`
- `json-lsp`

### Notes

`cmake-language-server` has a dependency, `pygls`, which introduced compatibility
breaking changes in version `2.0.0`. Since the package is not yet fixed to address
these changes, you should manually remove the installed version of `pygls` and
install an older version yourself. Go to the place in which `cmake-language-server`
dependencies are installed (it was
`/Users/armaho/.local/share/nvim/mason/packages/cmake-language-server` on
your mac), and run the following commands:

```bash
$ source venv
$ pip uninstall pygls
$ pip install "pygls>=1.1.1, <2.0.0"
```

## Package Manager

- `fd`
- `rg`

