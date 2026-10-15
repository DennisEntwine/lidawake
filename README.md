# lidawake

Menu bar button that flips `pmset disablesleep` between 0 and 1, so your Mac keeps running with the lid closed (or goes back to normal).

```bash
curl -fsSL https://raw.githubusercontent.com/DennisEntwine/lidawake/main/install.sh | bash
```

- Moon icon: normal, closing the lid sleeps.
- Sun icon: stays awake with the lid closed. Turn it off before it goes in a bag.
- CLI: `lidawake toggle`

Installs [SwiftBar](https://github.com/swiftbar/SwiftBar) (via Homebrew) and a sudoers rule allowing only `pmset -a disablesleep 0|1` without a password.

Uninstall:

```bash
sudo rm /etc/sudoers.d/lidawake /usr/local/bin/lidawake
rm ~/.swiftbar/lidawake.10s.sh
```
