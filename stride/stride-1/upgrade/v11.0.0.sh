cd $HOME/stride
git fetch --all
git checkout v11.0.0
make install
strided version
#commit: 4b5d80ac5cafb418debc8a860959d4a6c6797cfb
#version: v11.0.0
systemctl restart strided && journalctl -u strided -f -o cat
