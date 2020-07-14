# colcon-clean.fish

colcon-clean command for fish-shell

## Prerequisites

- [fd](https://github.com/sharkdp/fd)

### Using apt (Ubuntu 20.04)

```sh
sudo apt install fd-find
sudo ln -snfv /usr/bin/fdfind /usr/bin/fd
```

### Using Homebrew / Linuxbrew

```sh
brew install fd
```

## Installation

### Using fisher (recommended)

```sh
fisher add kenji-miyake/colcon-clean.fish
```

### Using local-install script (for development)

```sh
git clone git@github.com:kenji-miyake/colcon-clean.fish.git
cd colcon-clean.fish
./install
```

## Usage

```sh
cd {colcon_workspace_dir}
colcon-clean {package_name_1} {package_name_2} # To delete packages
colcon-clean # To delete whole workspace
```

> Note
>
> This tool uses `.repos` file to find the workspace root directory.
