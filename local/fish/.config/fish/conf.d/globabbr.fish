# https://gitlab.com/Lotz/fish_globabbr/-/tree/master

function __fish_expand_globabbreviation
#    if test (count (commandline -poc)) -eq 0
        set -l token (commandline -t)

        if globabbreviations -q $token
            commandline -t (globabbreviations $token)
            return 0
        else
            return 1
        end
#    end
end

bind \  '__fish_expand_globabbreviation || commandline -i " "'
# bind \n '__fish_expand_abbreviation; commandline -f execute'

function globabbreviations --description 'List, show and query abbreviations'
    if test (count $argv) = 0
        printf '%s\n' $fish_globabbreviations
        return
    end

    set -l globabbreviation_index 0
    set -l expanded_globabbreviation

    for i in $fish_globabbreviations
        set globabbreviation_index (math $globabbreviation_index + 1)
        echo $i | read -l abbreviation command

        if test $abbreviation = $argv[-1]
            set expanded_globabbreviation $command
            break
        end
    end

    if test -n "$expanded_globabbreviation"
        switch $argv[1]
            case -q --query
                return 0
            case -e --erase
                set -e fish_globabbreviations[$globabbreviation_index]
            case '*'
                echo $expanded_globabbreviation
        end
    else
        return 1
    end
end

function globabbr --description 'Define a new abbreviation'
    if test (count $argv) -lt 2
        echo 'globabbr: Takes two arguments. First abbreviation and then expanded command'
        return 1
    end

    echo $argv | read -l abbreviation command
    # uncommented the following line to make it work the way I want
    # eval "function $abbreviation; $command \$argv; end"
    globabbreviations -e $abbreviation

    set -U fish_globabbreviations $fish_globabbreviations "$argv"
    return 0
end
