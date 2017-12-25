DAY?=00

all:
	@echo "Building day${DAY}..."
	gprbuild -P ada_gnat_project.gpr -XDay=${DAY}

run: all
	@echo "Runnig..."
	@./day${DAY}/obj/main
