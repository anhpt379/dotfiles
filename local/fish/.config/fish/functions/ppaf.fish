function ppaf --wraps='sudo killall puppet 2>/dev/null; pp --enable; ppa' --description 'alias ppaf sudo killall puppet 2>/dev/null; pp --enable; ppa'
    sudo killall puppet 2>/dev/null
    sleep 1
    pp --enable
    ppa $argv
end
