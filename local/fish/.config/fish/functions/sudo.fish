# A sudo command that preserves environment vars & aliases
# This is needed until https://github.com/fish-shell/fish-shell/issues/5003 is
# resolved.
function sudo -d "sudo wrapper that preserves environment vars and aliases"
    if functions -q -- $argv[1]
        set -l new_args (string join ' ' -- (string escape -- $argv))
        set argv fish -c "$new_args"
    end

    command sudo -E $argv
end
