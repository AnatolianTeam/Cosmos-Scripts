cd $HOME
wget https://github.com/crossfichain/crossfi-node/releases/download/v0.3.0-prebuild9/crossfi-node_0.3.0-prebuild9_linux_amd64.tar.gz
tar -xvf crossfi-node_0.3.0-prebuild9_linux_amd64.tar.gz
chmod +x $HOME/bin/crossfid
rm crossfi-node_0.3.0-prebuild9_linux_amd64.tar.gz
mv $HOME/bin/crossfid $(which crossfid)
systemctl restart crossfid && journalctl -u crossfid -f