# syntax=docker/dockerfile:1
FROM debian
USER root
RUN apt-get update
# Utilities
RUN apt --yes --force-yes install unzip
RUN apt --yes --force-yes install default-jre
RUN apt --yes --force-yes install python3
RUN apt --yes --force-yes install python3.11-venv
RUN apt --yes --force-yes install cmake
RUN apt --yes --force-yes install libgl-dev
RUN apt --yes --force-yes install libgl1-mesa-dev
RUN apt --yes --force-yes install pkg-config
RUN apt --yes --force-yes install curl
RUN apt --yes --force-yes install tar
RUN apt --yes --force-yes install xz-utils
RUN apt --yes --force-yes install ninja-build
# Vulkan SDK
RUN apt --yes --force-yes install qtbase5-dev libxcb-xinput0 libxcb-xinerama0
RUN mkdir VulkanSDK
RUN curl -o /VulkanSDK/vulkansdk.tar.xz https://sdk.lunarg.com/sdk/download/1.3.290.0/linux/vulkansdk-linux-x86_64-1.3.290.0.tar.xz
RUN tar xf /VulkanSDK/vulkansdk.tar.xz
RUN cd 1.3.290.0
RUN export VULKAN_SDK=~/VulkanSDK/1.3.290.0/x86_64
RUN export PATH=$VULKAN_SDK/bin:$PATH
RUN export LD_LIBRARY_PATH=$VULKAN_SDK/lib${LD_LIBRARY_PATH:+:$LD_LIBRARY_PATH}
RUN export VK_LAYER_PATH=$VULKAN_SDK/share/vulkan/explicit_layer.d
# GCC
RUN apt --yes --force-yes install build-essential
# Clang
RUN apt --yes --force-yes install clang
# Teamcity 
ADD buildAgent.zip /build_agent/buildAgent.zip
RUN unzip /build_agent/buildAgent.zip -d /build_agent
RUN chmod 7777 /build_agent/bin/agent.sh
CMD ["/build_agent/bin/agent.sh", "run"]
