function __colcon_get_candidate_pkgs
    # Find workspace directory
    set -l workspace_dir (__colcon_get_workspace_dir) || return 1

    # Check base_dir
    set -l base_dir "$workspace_dir/install"
    test -d $base_dir || return 1

    # Find candidate packages
    set candidate_pkgs (fd -t d --max-depth 1 . $base_dir | xargs -I {} basename {})

    # Validate
    test "$candidate_pkgs" = "" && return 1

    # Output
    printf "%s\n" $candidate_pkgs | awk '!x[$0]++'

    return 0
end
