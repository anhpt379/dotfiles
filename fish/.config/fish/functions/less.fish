function less -d "colorized less"
    if [ (count $argv) -lt 1 ]
        command grcat conf.auto 2>/dev/null | command less
    else
        command grcat conf.auto < $argv 2>/dev/null | command less
    end
end
