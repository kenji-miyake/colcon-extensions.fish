# colcon-extensions.fish

colcon extensions commands for fish-shell

## Prerequisites

- [fd](https://github.com/sharkdp/fd)

### Using apt (Ubuntu 20.04+)

```fish
sudo apt install fd-find
sudo ln -snfv /usr/bin/fdfind /usr/bin/fd
```

## Installation

### Using fisher (recommended)

```fish
fisher install kenji-miyake/colcon-extensions.fish
```

### Using local-install script (for development)

```fish
git clone git@github.com:kenji-miyake/colcon-extensions.fish.git
cd colcon-extensions.fish
./install
```

## Usage

This tool supposes that a `.repos` file is placed right under your workspace root directory.

```fish
tocuh dummy.repos
```

### colcon-clean

This command deletes selected packages or whole build artifacts.

```fish
cd {colcon_workspace_dir}
colcon-clean {package_name_1} {package_name_2} # To delete selected packages
colcon-clean # To delete whole build artifacts
```
