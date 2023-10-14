# https://github.com/oribe1115/traP-isucon-newbie-handson2022-demo/blob/main/Makefile

# install tools
.PHONY: install-tools
install-tools:
	sudo apt update
	sudo apt upgrade
	sudo apt install -y git unzip tar

	# alp
	wget https://github.com/tkuchiki/alp/releases/download/v1.0.21/alp_linux_amd64.tar.gz
	tar xf alp_linux_amd64.tar.gz
	sudo install alp /usr/local/bin/alp
	rm alp
	rm alp_linux_amd64.tar.gz

# setup git
