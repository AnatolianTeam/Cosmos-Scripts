# Upgrade to v5.0.0

## tmux Install
```shell
sudo apt update
sudo apt install -y tmux
```

## Auto Update
```shell
tmux new -s rebus-v040 "bash <(curl -s https://raw.githubusercontent.com/AnatolianTeam/Cosmos-Scripts/main/utils/schedule_upgrade.sh) -n rebus -i reb_1111-1 -t 9464700 -v v0.4.0 -b rebusd -c https://github.com/AnatolianTeam"
```

### Exit tmux session
`press CTRL+B then leave hands and then press D`
