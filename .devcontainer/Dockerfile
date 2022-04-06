FROM python:3.9-slim

# set home as working directory before cloning repos
WORKDIR /root

# clone nodemcu-firmware repo (source: https://nodemcu.readthedocs.io/en/release/build/)
RUN git clone --recurse-submodules https://github.com/nodemcu/nodemcu-firmware.git

# install esptool (source: https://docs.espressif.com/projects/esptool/en/latest/esp8266/index.html)
RUN pip install esptool

# install nodejs lts (source: https://github.com/nodesource/distributions)
RUN curl -fsSL https://deb.nodesource.com/setup_lts.x | bash - && apt-get install -y nodejs

# install nodemcu-tool (source: https://github.com/andidittrich/NodeMCU-Tool)
RUN npm install -g nodemcu-tool
