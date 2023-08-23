# Upgrade to v1.3.0

## tmux Install
```shell
sudo apt update
sudo apt install -y tmux
```

## Auto Update
```shell
tmux new -s c4e-v130 "bash <(curl -s https://raw.githubusercontent.com/AnatolianTeam/Cosmos-Scripts/main/utils/schedule_upgrade.sh) -n c4e -i babajaga-1 -t 1642091 -v v1.3.0 -b c4ed -c https://github.com/AnatolianTeam"
```

### Exit tmux session
`press CTRL+B then leave hands and then press D`
