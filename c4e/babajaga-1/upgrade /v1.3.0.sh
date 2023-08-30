systemctl stop c4ed
cd $HOME
rm -rf c4e-chain
git clone https://github.com/chain4energy/c4e-chain.git
cd c4e-chain
git fetch --tags
git checkout v1.3.0
make install
c4ed version
mv build/c4ed $(which c4ed)
mv ~/go/bin/c4ed /usr/local/bin/c4ed
systemctl restart c4ed
