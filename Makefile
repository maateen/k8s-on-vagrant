up:
	cd master-1; vagrant up
	cd worker-1; vagrant up

up-all:
	cd master-1; vagrant up
	cd worker-1; vagrant up
	cd worker-2; vagrant up

halt:
	cd master-1; vagrant halt
	cd worker-1; vagrant halt

halt-all:
	cd master-1; vagrant halt
	cd worker-1; vagrant halt
	cd worker-2; vagrant halt

down:
	cd master-1; vagrant suspend
	cd worker-1; vagrant suspend

down-all:
	cd master-1; vagrant suspend
	cd worker-1; vagrant suspend
	cd worker-2; vagrant suspend