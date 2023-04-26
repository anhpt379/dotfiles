function ppf --wraps='sudo killall puppet 2>/dev/null; pp --enable; pp' --description 'alias ppf sudo killall puppet 2>/dev/null; pp --enable; pp'
    sudo killall puppet 2>/dev/null
    pp --enable
    pp $argv
end
