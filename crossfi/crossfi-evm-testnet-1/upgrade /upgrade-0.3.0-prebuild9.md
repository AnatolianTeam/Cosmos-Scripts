# Upgrade to v0.3.0-prebuild9

## tmux Install
```shell
sudo apt update
sudo apt install -y tmux
```

## Auto Update
```shell
tmux new -s crossfi-v030-prebuild9 "bash <(curl -s https://raw.githubusercontent.com/AnatolianTeam/Cosmos-Scripts/main/utils/schedule_upgrade.sh) -n crossfi -i crossfi-evm-testnet-1 -t 3520000 -v v0.3.0-prebuild9 -b crossfid -c https://github.com/AnatolianTeam"
```

### Exit tmux session
`press CTRL+B then leave hands and then press D`
