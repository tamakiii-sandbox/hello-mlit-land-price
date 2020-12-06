.PHONY: help setup dependencies version clean

help:
	@cat $(firstword $(MAKEFILE_LIST))

setup: \
	dependencies

dependencies:
	type sbt

version:
	sbt --version # -sbt-create

clean:
