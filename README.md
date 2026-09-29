nvim for debian commands
```
sudo apt update
sudo apt install -y nodejs npm build-essential git curl unzip tar python3-venv```

```
\# 1. Download the 0.11+ build
curl -LO https://github.com/neovim/neovim/releases/download/nightly/nvim-linux-x86_64.tar.gz

\# 2. Extract into /opt
rm -rf /opt/nvim-linux-x86_64
tar -C /opt -xzf nvim-linux-x86_64.tar.gz

\# 3. Symlink to /usr/local/bin and /usr/bin (prevents PATH shadowing)
ln -sf /opt/nvim-linux-x86_64/bin/nvim /usr/local/bin/nvim
ln -sf /opt/nvim-linux-x86_64/bin/nvim /usr/bin/nvim

\# 4. Refresh your shell's command hash table
hash -r

\# 5. Verify the version output shows v0.11.x
nvim --version
```

clear old config
'''
rm -rf ~/.local/share/nvim/lazy
rm -rf ~/.local/state/nvim
nvim
```
