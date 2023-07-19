cd $HOME/stride
git fetch --all
git checkout v12.1.0
make install
strided version
#commit: bbf0bb7f52878f3205c76bb1e96662fe7bd7af8d
#version: v12.1.0
wget -O $HOME/.stride/config/ccv.json "https://raw.githubusercontent.com/Stride-Labs/mainnet/main/ics-instructions/ccv.json"
systemctl restart strided
