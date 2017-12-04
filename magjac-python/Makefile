all:
	for dir in */day/[0-9]/part[12]; do $(MAKE) -C $$dir; done

push:
	git push origin `git rev-parse --abbrev-ref HEAD`
