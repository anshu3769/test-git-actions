IMAGE_BASE = git-actions-test

.PHONY: build-%
build-%:
	docker build --target=$* -t $(IMAGE_BASE):$* .
