# source: https://jmkhael.io/makefiles-for-your-dockerfiles/
# Run in parallel via make -j2 see: https://stackoverflow.com/a/9220818

NS = cmusei
export SOFTWARE_NAME = super_mediator

export IMAGE_NAME += $(NS)/$(SOFTWARE_NAME)

export WORK_DIR = .

.PHONY: build build1 build2 test

build: build1

build1:
	docker build --build-arg http_proxy --build-arg https_proxy --build-arg no_proxy -t $(IMAGE_NAME):latest -f Dockerfile .
	docker tag $(IMAGE_NAME):latest $(IMAGE_NAME):1

build2:
	docker build --build-arg http_proxy --build-arg https_proxy --build-arg no_proxy --build-arg FIXBUF_VERSION=3 \
	       --build-arg SUPER_VERSION=2.0.0.alpha3 -t $(IMAGE_NAME):2 -f Dockerfile .	

test:
	docker rm -f $(SOFTWARE_NAME)
	docker run --name=$(SOFTWARE_NAME) --entrypoint=/bin/bash -td $(IMAGE_NAME)
	py.test --hosts='docker://$(SOFTWARE_NAME)'
	docker rm -f $(SOFTWARE_NAME)

default: build