up:
	cd master-1; vagrant up
	cd worker-1; vagrant up
	cd worker-2; vagrant up

halt:
	cd master-1; vagrant halt
	cd worker-1; vagrant halt
	cd worker-2; vagrant halt

down:
	cd master-1; vagrant suspends
	cd worker-1; vagrant suspends
	cd worker-2; vagrant suspends