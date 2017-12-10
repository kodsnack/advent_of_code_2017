SUBDIRS = $(shell echo */day/[0-9]/part[12])

all: $(SUBDIRS)

$(SUBDIRS):
	$(MAKE) -C $@

.PHONY: all $(SUBDIRS)

push:
	git push origin `git rev-parse --abbrev-ref HEAD`
