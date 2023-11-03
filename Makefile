# https://github.com/oribe1115/traP-isucon-newbie-handson2022-demo/blob/main/Makefile

GIT_DIR:=

# setup ssh
.PHONY: setup-ssh
setup-ssh:
	touch ~/.ssh/authorized_keys
	chmod 600 ~/.ssh/authorized_keys
	curl https://github.com/putcut.keys >> ~/.ssh/authorized_keys
	curl https://github.com/akki-F.keys >> ~/.ssh/authorized_keys
	curl https://github.com/yorosikop.keys >> ~/.ssh/authorized_keys

# install tools
.PHONY: install-tools
install-tools:
	sudo apt update -y
	sudo apt upgrade -y
	sudo apt install -y git unzip tar

	# alp
	wget https://github.com/tkuchiki/alp/releases/download/v1.0.21/alp_linux_amd64.tar.gz
	tar xf alp_linux_amd64.tar.gz
	sudo install alp /usr/local/bin/alp
	rm alp
	rm alp_linux_amd64.tar.gz

.PHONY: git-setup
	git config --global user.email "putcutpoint@gmail.com"
	git config --global user.name "putcut"

	# deploykeyの作成
	ssh-keygen -t ed25519