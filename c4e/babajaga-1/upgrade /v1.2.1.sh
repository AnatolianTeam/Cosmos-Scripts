systemctl stop c4ed

cd || return
rm -rf 4e-chain
git clone --depth 1 --branch v1.2.1 https://github.com/chain4energy/c4e-chain.git
cd canine-chain || return
git checkout v1.2.1
make install

systemctl start c4ed
