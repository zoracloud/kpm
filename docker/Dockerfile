# the builder has: git, wget, cmake, gcc/g++, make, python2/3. v7 dropped nng support
#
ARG CONTAINER_PULL_REGISTRY=nexus3.o-ran-sc.org:10001
FROM ${CONTAINER_PULL_REGISTRY}/o-ran-sc/bldr-ubuntu18-c-go:1.9.0 as buildenv


# spaces to save things in the build image to copy to final image
RUN mkdir -p /playpen/assets /playpen/src /playpen/bin
ARG SRC=.

WORKDIR /playpen


# versions we snarf from package cloud
ARG E2SIM_VER=1.0.0

# snarf up E2SIM dependencies, then pull E2SIM package and install
# Dependencies: sctp

RUN apt-get update \
	&& apt-get install -y \
	build-essential \
	git \
	cmake \
	libsctp-dev \
	lksctp-tools \
	autoconf \
	automake \
	libtool \
	bison \
	flex \
  libboost-all-dev \
	iputils-ping \
	net-tools \
	nano \
	vim \
	tcpdump \
	net-tools \
	nmap \
  && apt-get clean


#RUN wget -nv --content-disposition ${PC_STG_URL}/sdl_${SDL_VER}-1_amd64.deb/download.deb && \
#	wget -nv --content-disposition ${PC_STG_URL}/sdl-dev_${SDL_VER}-1_amd64.deb/download.deb &&\
#	dpkg -i sdl-dev_${SDL_VER}-1_amd64.deb sdl_${SDL_VER}-1_amd64.deb

#
# build and install the application(s)
#


COPY ../e2sim_1.0.0_amd64.deb /playpen
COPY ../e2sim-dev_1.0.0_amd64.deb /playpen

RUN dpkg -i e2sim_1.0.0_amd64.deb e2sim-dev_1.0.0_amd64.deb

RUN mkdir /usr/local/include/nlohmann
RUN git clone https://github.com/azadkuh/nlohmann_json_release.git
RUN cp nlohmann_json_release/json.hpp /usr/local/include/nlohmann

COPY .. /playpen/src/
RUN wc -l /playpen/src/reports.json
RUN cd /playpen/src && \
	rm -fr .build &&\
	mkdir  .build && \
	cd .build && \
	cmake .. && \
	make install

EXPOSE 36422
CMD kpm_sim 10.110.102.29 36422
