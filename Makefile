.PHONY: build_dev build_dev_vim build_layers build run

build_dev:
	docker build -t voxgraph_dev ./layer_dev

build_dev_vim:
	docker build -t voxgraph_dev_vim ./layer_vim

build_layers:
	make build_dev
	make build_dev_vim

build: build_layers
	docker build -t voxgraph_vs .

run: build
	docker run --rm -it --name voxgraph_vs\
		--cap-add=SYS_PTRACE --security-opt seccomp=unconfined \
			--gpus all \
			--name voxgraph_vs \
			-e DISPLAY=${DISPLAY} \
			-e QT_X11_NO_MITSHM=1 \
			-e XAUTHORITY=/tmp/.docker.xauth \
			-e HOME=${HOME} \
			-v /tmp/.X11-unix:/tmp/.X11-unix:rw \
			-v /tmp/.docker.xauth:/tmp/.docker.xauth \
			-v ${HOME}/Datasets:${HOME}/Datasets \
			-v ${HOME}/Workspace/mrslam/coxslam_ws:${HOME}/Workspace/mrslam/coxslam_ws/ \
			-v ${HOME}/Workspace/mrslam/orbslam_2_ros_ws:${HOME}/Workspace/mrslam/orbslam_2_ros_ws/ \
			-v ${HOME}/Workspace/mrslam/sysmon_ws:${HOME}/Workspace/mrslam/sysmon_ws/ \
			-v ${HOME}/Workspace/mrslam/maskgraph_ws/voxgraph_ws:${HOME}/Workspace/mrslam/maskgraph_ws/voxgraph_ws \
			-v ${HOME}/Workspace/mrslam/maskgraph_ws/voxgraph_melodic_ws:/workspaces/voxgraph_melodic_ws/ \
			-v /etc/localtime:/etc/localtime \
			-p2222:22 \
			--runtime=nvidia \
			--privileged \
			voxgraph_vs
