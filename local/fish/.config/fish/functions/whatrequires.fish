function whatrequires --wraps='rpm -q --whatrequires' --description 'alias whatrequires rpm -q --whatrequires'
    rpm -q --whatrequires $argv
end
