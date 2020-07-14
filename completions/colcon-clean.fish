# positional arguments
complete -c colcon-clean -f -a "(__colcon_get_candidate_pkgs)"

# optional arguments
complete -c colcon-clean -s y -l yes -d "force clean"
