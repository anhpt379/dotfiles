function note -d "Manage notes in ~/Workspace/notes"
    set current_dir (pwd)

    cd ~/Workspace/notes/

    set cmd_name $_
    if [ $cmd_name = "n" ]
        echo -e "\n\n===============================================================================" >> zZz.txt
        echo -n (date) >> zZz.txt
        if [ (count $argv) -gt 0 ]
          echo -n ": "$argv >> zZz.txt
        end
        echo -e "\n===============================================================================\n" >> zZz.txt
        nvim "+normal Go" +startinsert zZz.txt
        exit 0
    else
        set file_to_open (
            python3 -c '
import os

files = os.listdir(".")
files.sort()

first_empty_file = None
output = []
for f in files:
    data = open(f).read(100)
    lines = [
        line
        for line in data.splitlines()
        if line.strip() and "# vim" not in line
    ]
    if not lines:
        if not first_empty_file:
            first_empty_file = f
            output.insert(0, f)
        else:
            output.append(f)
        continue

    preview = lines[0].lstrip("-#*").strip()
    if len(preview) > 50:
        preview = preview[:50] + "..."
    output.append(f"{f} \033[2m{preview}\033[0m")

print("\n".join(output))' | ~/.local/bin/devicon.py | \
            fzf --preview="bat --color=always --line-range :100 (echo {} | cut -d' ' -f2)" \
                --preview-window=right:70% \
                --height=100% --print-query --ansi | \
            tail -1 | ~/.local/bin/devicon.py remove
        )

        if string length -q -- "$file_to_open"
            nvim "$file_to_open"
        end
    end

    cd $current_dir
end
