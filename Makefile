FAUSTGH="ghcr.io/orlarey/faustdocker"

build:
	docker build --squash -t $(FAUSTGH):latest -f Dockerfile .

push:
	docker push $(FAUSTGH):latest

test:
	docker run $(FAUSTGH):latest

help:
	@echo " 'build' : builds the docker image"
	@echo " 'test'  : run the docker image, equivalent to faust -v"
	@echo " 'push'  : push the docker image to docker repository"
 