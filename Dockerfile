FROM ros:indigo
# place here your application's setup specifics
#CMD [ "roslaunch", "my-ros-app my-ros-app.launch" ]
RUN apt-get -y update && \
	apt-get -y install ros-indigo-libg2o ros-indigo-cv-bridge liblapack-dev libblas-dev freeglut3-dev libqglviewer-dev libsuitesparse-dev libx11-dev

RUN sudo apt-get -y install python-rosinstall && \
	mkdir ~/rosbuild_ws && \
	cd ~/rosbuild_ws && \
	rosws init . /opt/ros/indigo && \
	mkdir package_dir && \
	yes | rosws set ~/rosbuild_ws/package_dir -t . 

SHELL ["/bin/bash", "-c"]

RUN source ~/rosbuild_ws/setup.bash && \
	cd ~/rosbuild_ws/package_dir &&\
	git clone https://github.com/JanElseberg/lsd_slam.git lsd_slam && \
	rosmake lsd_slam

#RUN /bin/sh -c ""
#	#echo "source ~/rosbuild_ws/setup.bash" >> ~/.bashrc && \
#	#cat ~/rosbuild_ws/setup.bash && \
#	#/bin/bash -c "cd ~/rosbuild_ws/package_dir; git clone https://github.com/tum-vision/lsd_slam.git lsd_slam; rosmake lsd_slam"
