install:
	mix deps.get

tests:
	mix test

build-docs:
	mix docs

interactive-shell:
	iex -S mix

new-project:
	mix new $(PROJECT)
