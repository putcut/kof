# https://github.com/oribe1115/traP-isucon-newbie-handson2022-demo/blob/main/Makefile

GIT_DIR:=
SERVICE_NAME:=
NGINX_LOG:=/var/log/nginx/access.log
SLOW_QUERY_LOG:=/var/log/mysql/mysql-slow.log

# setup ssh
.PHONY: setup-ssh
setup-ssh:
	mkdir ~/.ssh
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
	sudo apt install -y git unzip tar percona-toolkit

	# alp
	wget https://github.com/tkuchiki/alp/releases/download/v1.0.21/alp_linux_amd64.tar.gz
	tar xf alp_linux_amd64.tar.gz
	sudo install alp /usr/local/bin/alp
	rm alp
	rm alp_linux_amd64.tar.gz

.PHONY: git-setup
git-setup:
	git config --global user.email "putcutpoint@gmail.com"
	git config --global user.name "putcut"

	# deploykeyの作成
	ssh-keygen -t ed25519

.PHONY: truncate-log
truncate-log:
	sudo truncate $(NGINX_LOG) --size 0
	sudo truncate $(SLOW_QUERY_LOG) --size 0

.PHONY: rotate-log
rotate-log:
	$(eval when := $(shell date "+%s"))
	mkdir -p ~/logs/$(when)
	sudo test -f $(NGINX_LOG) && \
		sudo cp -f $(NGINX_LOG) ~/logs/nginx/$(when)/ || echo ""
	sudo test -f $(SLOW_QUERY_LOG) && \
		sudo cp -f $(SLOW_QUERY_LOG) ~/logs/mysql/$(when)/ || echo ""
	truncate-log

.PHONY: restart
restart:
	make truncate-log
	sudo systemctl daemon-reload
	sudo systemctl restart $(SERVICE_NAME)
	sudo systemctl restart mysql
	sudo systemctl restart nginx

.PHONY: alp
alp:
	sudo alp json --file=$(NGINX_LOG) --config=/home/isucon/conf/alp/config.yml

.PHONY: slow-query
slow-query:
	sudo pt-query-digest $(SLOW_QUERY_LOG)