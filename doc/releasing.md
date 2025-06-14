# Releasing

To release a new version, tag the commit ([Semver](https://semver.org/)) and push:

```sh
make current          # Current tag
make tag version=v0.2 # Create new tag e.g. v0.2
make push             # Push with tag
```
