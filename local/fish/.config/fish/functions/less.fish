function less
    if [ ! -t 1 ]
        command less --quit-if-one-screen $argv
        return
    end

    if [ (count $argv) -ge 1 ]
        set -f file $argv[-1]

        if [ -e "$file" ]
            set -f file_size (command ls -s --block-size=1048576 "$file" | cut -d' ' -f1) # in MB

            # Open big files, or files with one really long line with less
            if [ $file_size -gt 200 ] || [ "$(head --bytes=4096 "$file" 2>/dev/null | head -1 | wc --chars)" -gt 1000 ]
                command less --line-numbers $argv
                return
            end
        else
            echo "$file: No such file or directory"
            return 1
        end
    end

    nvimpager -a $argv
end
