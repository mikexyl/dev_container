.PHONY: build_dev build_dev_vim build_layers build run

build_dev:
	docker build -t maplab_dev ./layer_dev

build_dev_vim:
	docker build -t maplab_dev_vim ./layer_vim

build_layers:
	make build_dev
	make build_dev_vim

build: build_layers
	docker build -t maplab_vs .

run:
	docker run --name maplab_vs\
		--cap-add=SYS_PTRACE --security-opt seccomp=unconfined \
			--gpus all \
			-e DISPLAY=:0 \
			-e QT_X11_NO_MITSHM=1 \
			-e XAUTHORITY=/tmp/.docker.xauth \
			-e HOME=${HOME} \
			-v /tmp/.X11-unix:/tmp/.X11-unix:rw \
			-v /tmp/.docker.xauth:/tmp/.docker.xauth \
			--mount type=bind,source=${HOME}/Datasets,target=${HOME}/Datasets \
			--mount type=bind,source=${HOME}/Workspace_ssd/maplab_ws,target=${HOME}/Workspace_ssd/maplab_ws \
			--mount type=bind,source=${HOME}/Datasets_ssd,target=${HOME}/Datasets_ssd \
			--mount type=bind,source=${HOME}/.vimrc,target=${HOME}/.vimrc \
			--mount type=bind,source=${HOME}/.vim/coc-settings.json,target=${HOME}/.vim/coc-settings.json \
			--mount type=bind,source=${HOME}/.config/coc/,target=${HOME}/.config/coc/ \
			-v /etc/localtime:/etc/localtime \
			-p2222:22 \
			-p6666:6666 \
			--runtime=nvidia \
			--privileged \
			maplab_vs

start:
	docker start maplab_vs

attach:
	docker exec -it -u ${shell whoami} maplab_vs /bin/bash
