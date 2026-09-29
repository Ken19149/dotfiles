nvim for debian commands
install required tools for the config
```
sudo apt update
sudo apt install -y nodejs npm build-essential git curl unzip tar python3-venv```

install new version of nvim
```
curl -LO https://github.com/neovim/neovim/releases/download/nightly/nvim-linux-x86_64.tar.gz

rm -rf /opt/nvim-linux-x86_64
tar -C /opt -xzf nvim-linux-x86_64.tar.gz

ln -sf /opt/nvim-linux-x86_64/bin/nvim /usr/local/bin/nvim
ln -sf /opt/nvim-linux-x86_64/bin/nvim /usr/bin/nvim

hash -r

nvim --version
```

clear old config
```
rm -rf ~/.local/share/nvim/lazy
rm -rf ~/.local/state/nvim
nvim
```
