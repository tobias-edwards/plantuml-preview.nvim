# Contributing

## Developing

To develop the plugin locally with Lazy, point the plugin to the local version:

```lua
return {
	dir = "/Users/tobias/Repos/plantuml-preview.nvim",
	name = "plantuml-preview.nvim",
	config = function()
		require("plantuml-preview").setup({
			port = 3030,
		})
	end,
}
```

To reload the plugin:

```
:Lazy reload plantuml-preview.nvim
```

## Documentation

Help docs are handcrafted, and so an update to the README may require an update to the help docs.

Tips:

- `:h help-writing` - help docs on writing plugin help docs
- `:set colorcolumn=78` - mark column width
- `:set textwidth=78` - auto-wrap new lines based on text width
- `:set fo+=t` - format on textwidth
- `gqG` - `gq{motion}` format lines from current to end. Will help format
  existing lines
- `:set ft=txt` - remove markup on `help` file type. Easier to edit
- `:helptags ALL` - generate help tags, and updates local `tags` file

## Releasing

To release a new version, tag the commit ([Semver](https://semver.org/)) and push:

```sh
make current          # Current tag
make tag version=v0.2 # Create new tag e.g. v0.2
make push             # Push with tag
```
