#!/usr/bin/env bash

# Disable sound on Ctrl-/ (when show/hide fzf preview)
defaults write com.apple.systemsound com.apple.sound.uiaudio.enabled -int 0

# Text correction
defaults write NSGlobalDomain NSAutomaticCapitalizationEnabled -bool false      # Disable automatic capitalization
defaults write NSGlobalDomain NSAutomaticPeriodSubstitutionEnabled -bool false  # Disable period substitution
defaults write NSGlobalDomain NSAutomaticQuoteSubstitutionEnabled -bool false   # Disable smart quotes
defaults write NSGlobalDomain NSAutomaticDashSubstitutionEnabled -bool false    # Disable smart dashes
defaults write NSGlobalDomain NSAutomaticSpellingCorrectionEnabled -bool false  # Disable auto-correct
defaults write NSGlobalDomain NSAutomaticTextCompletionEnabled -bool false      # Disable text-completion

# CMD+CONTROL & mouse click anywhere to drag a window
defaults write -g NSWindowShouldDragOnGesture -bool true

# Keyboard
defaults write NSGlobalDomain InitialKeyRepeat -int 15
defaults write NSGlobalDomain KeyRepeat -int 1

# Trackpad
defaults write com.apple.universalaccess mouseDriverCursorSize -float 2.0

# Enable full keyboard access for all controls
# (e.g. enable Tab in modal dialogs)
defaults write NSGlobalDomain AppleKeyboardUIMode -int 3

# Disable press-and-hold for keys in favor of key repeat
defaults write NSGlobalDomain ApplePressAndHoldEnabled -bool false

# Finder
defaults write NSGlobalDomain AppleShowAllExtensions -bool true              # Show all file extensions
defaults write com.apple.finder AppleShowAllFiles -bool true                 # Show hidden files
defaults write com.apple.finder ShowStatusBar -bool true                     # Show status bar
defaults write com.apple.finder ShowPathbar -bool true                       # Show path bar
defaults write com.apple.finder ShowRecentTags -bool false                   # Hide tags in sidebar
defaults write com.apple.finder _FXSortFoldersFirst -bool true               # Keep folders on top when sorting by name
defaults write com.apple.finder FXDefaultSearchScope -string "SCcf"          # Search the current folder by default
defaults write com.apple.finder FXEnableExtensionsChangeWarning -bool false  # Disable file extension change warning
killall Finder

# Dock
defaults write com.apple.dock tilesize -int 72
defaults write com.apple.dock magnification -bool true
defaults write com.apple.dock largesize -int 128
defaults write com.apple.dock autohide -bool true
defaults write com.apple.dock autohide-time-modifier -float 0.25
defaults write com.apple.dock autohide-delay -float 0
defaults write com.apple.dock minimize-to-application -bool true
defaults write com.apple.dock mru-spaces -bool false
defaults write com.apple.dock show-recents -bool false

# Set top right hot corner to show Notification Center
# Hot corner action values:
#   0  = No action
#   2  = Mission Control
#   3  = Application Windows
#   4  = Desktop
#   5  = Start Screen Saver
#   6  = Disable Screen Saver
#   7  = Dashboard
#   10 = Put Display to Sleep
#   11 = Launchpad
#   12 = Notification Center
#   13 = Lock Screen
#
# Corner positions:
#   wvous-tl-corner = Top Left
#   wvous-tr-corner = Top Right
#   wvous-bl-corner = Bottom Left
#   wvous-br-corner = Bottom Right
#
# Modifier values:
#   0 = No modifier
#   131072 = Shift
#   262144 = Control
#   524288 = Option
#   1048576 = Command
defaults write com.apple.dock wvous-tr-corner -int 12
defaults write com.apple.dock wvous-tr-modifier -int 0

killall Dock

# Desktop
defaults write com.apple.WindowManager EnableStandardClickToShowDesktop -bool false
osascript -e 'tell application "System Events" to tell every desktop to set picture to "/System/Library/Desktop Pictures/Solid Colors/Black.png"'
osascript -e 'tell application "System Events" to tell appearance preferences to set dark mode to false'
defaults write com.apple.screencapture location ~/Documents/Screenshots
defaults write com.apple.WindowManager GloballyEnabled -bool true           # Turn on Stage Manager

# Rectangle
defaults write com.knollsoft.Rectangle almostMaximizeHeight -float 1
defaults write com.knollsoft.Rectangle almostMaximizeWidth  -float 0.66
