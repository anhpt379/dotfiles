# A sudo command that preserves environment vars & aliases
# This is needed until https://github.com/fish-shell/fish-shell/issues/5003 is
# resolved.
function sudo
    if test "$argv[1]" = "vim"
        command sudo -E nvim $argv[2..-1]
    else if test "$argv[1]" = "nv"
        command sudo -E nvim $argv[2..-1]
    else
        command sudo -E $argv
    end
end
