# Console messages were written with reference to https://github.com/catkin/catkin_tools
function colcon-clean
    # Parse arguments
    set -l options "y/yes"
    argparse $options -- $argv || return 1

    # Find workspace directory
    set -l workspace_dir (__colcon_get_workspace_dir)
    if [ "$workspace_dir" = "" ]
        echo "[clean] No workspace found."
        return 1
    end

    # Check package name is given
    set -l package_name $argv[1]
    if [ "$package_name" = "" ]
        set -q _flag_yes && set force_clean true || set force_clean false
        clean_all $force_clean
    else
        clean_packages $argv
    end
end

function read_confirm
    read -l -P "[clean] Are you sure you want to completely remove the directories listed above? [yN]: " confirm
    switch $confirm
        case Y y
            return 0
        case "" N n
            return 1
    end
end

function clean_all
    set -l force_clean $argv[1]
    set -l workspace_dir (__colcon_get_workspace_dir)

    set msgs "[clean] Warning: This will completely remove the following directories. (Use `--yes` to skip this check)"
    set target_dirs

    if [ -d "$workspace_dir/log/" ]
        set msgs $msgs "[clean] Log Space:     $workspace_dir/log"
        set target_dirs $target_dirs "$workspace_dir/log"
    end

    if [ -d "$workspace_dir/log/" ]
        set msgs $msgs "[clean] Build Space:   $workspace_dir/build"
        set target_dirs $target_dirs "$workspace_dir/build"
    end

    if [ -d "$workspace_dir/log/" ]
        set msgs $msgs "[clean] Install Space: $workspace_dir/install"
        set target_dirs $target_dirs "$workspace_dir/install"
    end

    if [ "$target_dirs" = "" ]
        echo "[clean] Nothing to be cleaned"
        return 0
    end

    for msg in $msgs
        echo -e $msg
    end

    if $force_clean || read_confirm
        for target_dir in $target_dirs
            echo "Removing $target_dir"
            rm -rf $target_dir
        end
    else
        echo "[clean] Not removing any workspace directories for this profile."
    end
end

function clean_packages
    set -l packages $argv
    set -l workspace_dir (__colcon_get_workspace_dir)

    for package_name in $packages
        if [ -e "$workspace_dir/build/$package_name" ] || [ -e "$workspace_dir/install/$package_name" ]
            echo "[clean] $package_name"
            rm -rf $workspace_dir/build/$package_name $workspace_dir/install/$package_name
        else
            echo "[clean] There are no products from the given packages to clean."
        end
    end
end
