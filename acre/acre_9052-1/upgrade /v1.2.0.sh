sudo systemctl stop acred

cd || return
rm -rf acrechain
git clone https://github.com/ArableProtocol/acrechain.git
cd acrechain || return
git checkout v1.2.0
make install

sudo systemctl start acred
