# Upgrade to v5.0.0

## tmux Install
```shell
sudo apt update
sudo apt install -y tmux
```

## Auto Update
```shell
tmux new -s okp4-v500 "bash <(curl -s https://raw.githubusercontent.com/AnatolianTeam/Cosmos-Scripts/main/utils/schedule_upgrade.sh) -n OKP4 -i okp4-nemeton-1 -t 3052235 -v v5.0.0 -b okp4d -c https://github.com/AnatolianTeam"
```

### Exit tmux session
`press CTRL+B then leave hands and then press D`
