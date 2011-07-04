NAME=dotfiles
VERSION=0.1.1
PREFIX=/
TMPDIR=$(PREFIX)tmp/dotfiles
SKEL=$(PREFIX)etc/skel
BACKUP=.backup
SKELBACKUP=$(PREFIX)etc/skel$(BACKUP)
HOMEBACKUP=~/$(BACKUP)
BUILDDIR=/build/

install: backuphome installhome
	@@echo "Backed up and installed!"

$(HOMEBACKUP):
	@@mkdir -p $(HOMEBACKUP)

backuphome: $(HOMEBACKUP)
	@@echo -n "Backing up to $(HOMEBACKUP)..."
	$(shell test -f ~/.bashrc && \
		cp -f ~/.bashrc $(HOMEBACKUP)/bashrc)
	$(shell test -f ~/.vimrc && \
		cp -f ~/.vimrc $(HOMEBACKUP)/vimrc)
	$(shell test -d ~/.vim && \
		cp -rf ~/.vim $(HOMEBACKUP)/vim)
	$(shell test -d ~/.bash && \
		cp -rf ~/.bash $(HOMEBACKUP)/bash)
	@@echo " done."

installhome: backuphome
	@@echo -n "Installing dotfiles..."
	@@cp -f ./etc/bashrc ~/.bashrc
	@@cp -f ./etc/vimrc ~/.vimrc
	@@cp -rf ./etc/bash/* ~/.bash
	@@cp -rf ./etc/vim/* ~/.vim
	@@echo " done."

$(SKELBACKUP):
	@@mkdir -p $(SKELBACKUP)

backupskel: $(SKELBACKUP)
	@@echo -n "Backing up to $(SKELBACKUP)..."
	$(shell test -f $(SKEL)/.bashrc && \
		cp -f $(SKEL)/.bashrc $(SKELBACKUP)/bashrc)
	$(shell test -f $(SKEL)/.vimrc && \
		cp -f $(SKEL)/.vimrc $(SKELBACKUP)/vimrc)
	$(shell test -d $(SKEL)/.vim && \
		cp -rf $(SKEL)/.vim $(SKELBACKUP)/vim)
	$(shell test -d $(SKEL)/.bash && \
		cp -rf $(SKEL)/.bash $(SKELBACKUP)/bash)
	@@echo " done."

$(SKEL):
	@@mkdir -p $(SKEL)

installskel: $(SKEL)
	@@echo -n "Installing dotfiles to $(SKEL)..."
	@@cp -f ./etc/bashrc $(SKEL)/.bashrc
	@@cp -f ./etc/vimrc $(SKEL)/.vimrc
	@@cp -rf ./etc/bash/* $(SKEL)/.bash
	@@cp -rf ./etc/vim/* $(SKEL)/.vim
	@@echo " done."

package: deb
	@@echo "Package created."

$(TMP):
	@mkdir -p $(TMP)

deb:
	make installskel clean PREFIX=. BUILDDIR=$(BUILDDIR)
	#fpm -s dir \
	#	-t deb \
	#	-n $(NAME) \
	#	-v $(VERSION) \
	#	-a all \
	#	--prefix /etc/skel \
	#	-p $(NAME)-VERSION_ARCH.deb \
	#	etc

clean:
	rm -rf $(PREFIX)$(BUILDDIR)

.PHONY: all core backup install package
