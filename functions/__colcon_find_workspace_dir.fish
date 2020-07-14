function __colcon_find_workspace_dir
    set -l base_dir (pwd)

    while true
        # Find .repos files
        set -l repos_files (fd -I -t f -e repos --max-depth 1 . $base_dir)

        # Save directory name
        if [ "$repos_files" != "" ]
            set workspace_dir (dirname $repos_files[1])
            # Don't break to get the real workspace
        end

        # Check end condition
        set -l parent_dir (dirname $base_dir)
        if [ "$base_dir" = "$parent_dir" ]
            break
        end

        # Process parent directory
        set base_dir $parent_dir
    end

    # Validate
    test -d "$workspace_dir" || return 1

    # Output
    printf "%s\n" $workspace_dir

    return 0
end
