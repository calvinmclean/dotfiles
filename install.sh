#!/bin/bash

echo "deleting default ~/.config directory"
rm -r ~/.config
ln -s $(pwd)/.config ~/.config

echo "setting up gitconfig"
rm ~/.gitconfig
ln -s $(pwd)/.gitconfig ~/.gitconfig
