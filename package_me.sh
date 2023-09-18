#!/bin/bash

apt_howto() {
cat << 'EOC'
	aptitude -v why openssh-server
	sudo apt-cache {r,depends} openssh-server
EOC
}

pkg-config_hoto() {
cat << 'EOC'
	pkg-config --variable pc_path pkg-config
EOC
}
