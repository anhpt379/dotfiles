function update
    fisher update
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
    if command -v dnf
        sudo dnf update
    end
end
