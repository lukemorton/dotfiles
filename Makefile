all: core

core: backup install
	@@echo "Backed up and installed!"


backup:
	@@mkdir -p ~/.backup
	@@cp -f ~/.bashrc ~/.backup/bashrc
	@@cp -f ~/.vimrc ~/.backup/vimrc
	@@cp -rf ~/.vim ~/.backup/vim
	@@cp -rf ~/.bash ~/.backup/bash

install: backup 
	@@cp -f ./etc/bashrc ~/.bashrc
	@@cp -f ./etc/vimrc ~/.vimrc
	@@cp -rf ./etc/bash/* ~/.bash
	@@cp -rf ./etc/vim/* ~/.vim

.PHONY: all core backup install
