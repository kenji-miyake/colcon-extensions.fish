function __colcon_get_workspace_dir
    # Find workspace
    set workspace_dir (__colcon_find_workspace_dir)

    # Use current directory if no workspace was found
    if not test -d "$workspace_dir"
        set workspace_dir (pwd)
    end

    # Validate
    test -d "$workspace_dir/install" || return 1

    # Output
    printf "%s\n" $workspace_dir

    return 0
end
