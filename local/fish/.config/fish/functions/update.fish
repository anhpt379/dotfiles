function update
    fisher update
    omf update
    if command -v brew
        brew bundle
        brew bundle cleanup
        brew bundle cleanup --force
        brew outdated
        brew upgrade
    end
    if command -v tldr
        tldr --update
    end
end