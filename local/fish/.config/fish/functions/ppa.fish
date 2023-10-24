function ppa --wraps='command sudo HOME=/root TERMINFO=/home/panh/.terminfo puppet agent -t --environment=panh' --description 'alias ppa command sudo HOME=/root TERMINFO=/home/panh/.terminfo puppet agent -t --environment=panh'
    command sudo HOME=/root TERMINFO=/home/panh/.terminfo /bin/puppet agent -t --environment=panh $argv
end
