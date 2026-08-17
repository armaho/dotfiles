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
- `codelldb`
- `local-lua-debugger-vscode`

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

---

Inside `local-lua-debugger-vscode/extension/debugger/lldebugger.lua` there's
this loop which does not work on lua 5.5:

```lua
for path in scriptRootsStr:gmatch("[^;]+") do
  path = Path.format(path) .. Path.separator
  table.insert(scriptRoots, path)
end
```

Manually change it to:

```lua
for path in scriptRootsStr:gmatch("[^;]+") do
  table.insert(scriptRoots, Path.format(path) .. Path.separator)
end
```

Here's the related [pull request](https://github.com/tomblind/local-lua-debugger-vscode/pull/90).
It's not necessary to modify this piece of code if this pull request is merged.

## Package Manager

- `fd`
- `rg`
- `node`

