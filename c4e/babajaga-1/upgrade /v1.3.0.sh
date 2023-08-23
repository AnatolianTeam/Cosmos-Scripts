systemctl stop c4ed
cd || return
rm -rf c4e-chain
git clone --depth 1 --branch  v1.3.0  https://github.com/chain4energy/c4e-chain.git
cd c4e-chain
make install
systemctl start c4ed
