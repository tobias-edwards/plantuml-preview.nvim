**BETA**

# plantuml-preview

```
# check health
:health plantuml-preview

# lazy setup
{
    "tobias-edwards/plantuml-preview.nvim",
    config = function()
        require("plantuml-preview").setup()
    end,
}
```

## Roadmap

- [x] Squash all commits to protect from leakage
- [ ] Add release workflow?
- [x] Make public
- [x] Release v0.0.1-beta.0 and tag it
- [ ] Add `:help` documentation
- [ ] Add to Luarocks?
- [ ] Test and fix on Windows. MacOS working only atm

## Improvements

- [ ] Change browser title to filename
- [ ] Change callback syntax to `(error, callback)`--handle errors! More `pcall`?
- [ ] Allow to preview multiple plantuml buffers, increment port
- [ ] Drop Deno and run tcp-server from Lua

# Inspiration

- https://github.com/weirongxu/plantuml-previewer.vim
  - Good! But
    - dependencies: https://github.com/tyru/open-browser.vim
    - written in Vimscript
- https://github.com/Sol-Ponz/plantuml-previewer.nvim
  - Preview is within Neovim
- https://gitlab.com/itaranto/plantuml.nvim
  - Similar to above, but deprecated in favour of https://github.com/iamcco/markdown-preview.nvim

Why Deno?

- Simple APIs
- Built-in support for websockets
- Built-in watcher module
- Native TS support
