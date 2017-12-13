SUBDIRS = $(shell ls -d */day/[0-9]*/part[12] | sort -n -t/ -k 3)

all: $(SUBDIRS)

$(SUBDIRS):
	$(MAKE) -C $@

.PHONY: all $(SUBDIRS)

push:
	git push origin `git rev-parse --abbrev-ref HEAD`
