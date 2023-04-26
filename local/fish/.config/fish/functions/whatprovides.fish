function whatprovides --wraps='rpm -q --whatprovides' --description 'alias whatprovides rpm -q --whatprovides'
    rpm -q --whatprovides $argv
end
