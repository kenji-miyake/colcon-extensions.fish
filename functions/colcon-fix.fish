function colcon-fix
    # Parse arguments
    set -l options y/yes
    argparse $options -- $argv || return 1

    # Find workspace directory
    set -l workspace_dir (__colcon_get_workspace_dir)
    if [ "$workspace_dir" = "" ]
        echo "[fix] No workspace found."
        return 1
    end

    set -q _flag_yes && set force true || set force false

    set workspace_dir (__colcon_get_workspace_dir)
    cd $workspace_dir >/dev/null

    set target_dirs
    for package_name in (command colcon list --names-only)
        if not [ -f build/$package_name/Makefile ]
            continue
        end

        set package_path (rg 'CMAKE_SOURCE_DIR = (.*)' -r '$1' build/$package_name/Makefile)
        if not [ -d $package_path ]
            echo -e "[fix] build/$package_name install/$package_name"
            echo -e "[fix] Missin source directory: $package_path\n"
            set -a target_dirs build/$package_name install/$package_name
        end
    end

    if [ "$target_dirs" = "" ]
        echo "[fix] Nothing to be cleaned."
        return 0
    end

    if $force || read_confirm
        for target_dir in $target_dirs
            echo "Removing $target_dir."
            rm -rf $target_dir
        end
    else
        echo "[fix] Canceled."
    end
end

function read_confirm
    read -l -P "[fix] Are you sure you want to completely remove the directories listed above? [yN]: " confirm
    switch $confirm
        case Y y
            return 0
        case "" N n
            return 1
    end
end
