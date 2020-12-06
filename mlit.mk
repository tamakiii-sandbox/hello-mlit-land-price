.PHONY: help list setup dependencies download unzip clean

SLEEP := 10
zip := $(shell cat config/KsjTmplt.txt)
unzip := $(foreach z,$(zip),$(patsubst %.zip,%,$z))

help:
	@cat $(firstword $(MAKEFILE_LIST))

list:
	@$(MAKE) -pRrq -f $(lastword $(MAKEFILE_LIST)) : 2>/dev/null | awk -v RS= -F: '/^# File/,/^# Finished Make data base/ {if ($$1 !~ "^[#.]") {print $$1}}' | sort | egrep -v -e '^[^[:alnum:]]' | egrep -v -e '^$@$$'

setup: \
	dependencies

dependencies:
	type curl
	type unzip

download: $(zip)
unzip: $(unzip)

config/KsjTmplt.txt: dist/nlftp.mlit.go.jp/ksj/gml/datalist/KsjTmplt-L01-v2_5.html
	grep 'onclick="javascript:DownLd(' $< | grep -o 'data/.*.zip' | xargs -I@ echo 'dist/nlftp.mlit.go.jp/ksj/gml/@'

get-zip-list: dist/nlftp.mlit.go.jp/ksj/gml/datalist/KsjTmplt-L01-v2_5.html
	grep 'onclick="javascript:DownLd(' $< | grep -o '/data.*.zip'

dist/nlftp.mlit.go.jp/ksj/gml/datalist/KsjTmplt-L01-v2_5.html: dist
	curl --create-dirs "https://$(@:dist/%=%)" -o $@

define download

$1:
	curl --create-dirs -s "https://$$(@:dist/%=%)" -o $$@
	sleep $$(SLEEP)

endef

define unzip

$1: $1.zip
	unzip $$< -d $$@

endef

$(foreach z,$(zip),$(eval $(call download,$z)) )
$(foreach d,$(unzip),$(eval $(call unzip,$d)) )

dist:
	[ -d $@ ] || mkdir $@

clean:
	rm -rf dist

