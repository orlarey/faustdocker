FAUSTGH="ghcr.io/orlarey/faustdocker"

image:
	docker build -t $(FAUSTGH):main .

push:
	docker push $(FAUSTGH):main

test:
	docker run $(FAUSTGH):main

help:
	@echo " 'image' : builds the docker image"
	@echo " 'test'  : run the docker image, equivalent to faust -v"
	@echo " 'push'  : push the docker image to docker repository"
 
 