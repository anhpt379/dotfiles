function kubectl
    # FORCE_COLOR makes kubecolor colorize even when piped, which corrupts
    # `kubectl completion fish` (fish sources it, and the escape codes break
    # quoting), so let the completion script come from kubectl itself.
    if test "$argv[1]" = completion
        command kubectl $argv
    else
        kubecolor $argv
    end
end
