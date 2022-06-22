build-image:
	docker build -f docker/Dockerfile -t chepkoyallan/e2sim:1.0.0 .

run-image:
	docker run --rm --net host -it docker.io/chepkoyallan/e2sim:1.0.0 sh -c "./build/e2sim 127.0.0.1 36422"