function kc -d "Manage kubectl contexts"
    if [ (count $argv) -lt 1 ]
        kubectl config get-contexts
    else
        kubectl config use-context $argv
    end
end
