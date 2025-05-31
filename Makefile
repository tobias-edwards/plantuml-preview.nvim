current:
	@git describe --tags --abbrev=0

tag:
ifndef version
	$(error Usage: make tag version=v0.1)
endif
	@git tag -a $(version) -m "Release $(version)"
	@echo "Created tag: $(version)"

push:
	@latest_tag=$$(git describe --tags --abbrev=0); \
	echo "Pushing tag $$latest_tag"; \
	git push origin $$latest_tag
