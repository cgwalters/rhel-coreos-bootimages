manifestsdir := $(DESTDIR)/manifests

coreos-bootimages.json.generated: manifests/coreos-bootimages.json
	go run build.go $< $@.tmp && mv $@.tmp $@

all: coreos-bootimages.json.generated

install:
	mkdir -p $(manifestsdir)
	cp coreos-bootimages.json.generated $(manifestsdir)/coreos-bootimages.json

