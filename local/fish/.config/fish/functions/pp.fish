function pp --wraps='command sudo HOME=/root TERMINFO=/home/panh/.terminfo puppet agent -t' --description 'alias pp command sudo HOME=/root TERMINFO=/home/panh/.terminfo puppet agent -t'
    command sudo HOME=/root TERMINFO=/home/panh/.terminfo /bin/puppet agent -t $argv
end
