# Sets reasonable OS X defaults.
#
# Or, in other words, set shit how I like in OS X.
#
# The original idea (and a couple settings) were grabbed from:
#   https://github.com/mathiasbynens/dotfiles/blob/master/.osx
#
# Run ./set-defaults.sh and you'll be good to go.

# Disable press-and-hold for keys in favor of key repeat.
defaults write -g ApplePressAndHoldEnabled -bool false

# Use AirDrop over every interface. srsly this should be a default.
defaults write com.apple.NetworkBrowser BrowseAllInterfaces 1

# Always open everything in Finder's list view. This is important.
defaults write com.apple.Finder FXPreferredViewStyle Nlsv

# Show the ~/Library folder.
chflags nohidden ~/Library

# Set a really fast key repeat.
defaults write NSGlobalDomain KeyRepeat -int 2

# Set a higher mouse speed than is possible in System Preferences
defaults write -g com.apple.mouse.scaling 5.0

# Enable full keyboard access for all controls
# (e.g. enable Tab in modal dialogs)
defaults write NSGlobalDomain AppleKeyboardUIMode -int 3

# Set the Finder prefs for showing a few different volumes on the Desktop.
#defaults write com.apple.finder ShowExternalHardDrivesOnDesktop -bool true
#defaults write com.apple.finder ShowRemovableMediaOnDesktop -bool true

# When performing a search, search the current folder by default
defaults write com.apple.finder FXDefaultSearchScope -string "SCcf"
# Disable Spotlight Suggestions in Look Up
# https://twitter.com/craigmod/status/1177445871740305409
# https://daringfireball.net/linked/2019/10/10/spotlight-suggestions-in-look-up
defaults write com.apple.lookup.shared LookupSuggestionsDisabled -bool true

# Use list view in all Finder windows by default
# Four-letter codes for the other view modes: `icnv`, `clmv`, `Flwv`
defaults write com.apple.finder FXPreferredViewStyle -string "Nlsv"

# Avoid creating .DS_Store files on network volumes
defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true

# Show home folder when opening new windows
defaults write com.apple.finder NewWindowTarget -string "PfHm"
defaults write com.apple.finder NewWindowTargetPath -string "file://${HOME}/"

# Save to disk (not to iCloud) by default
defaults write NSGlobalDomain NSDocumentSaveNewDocumentsToCloud -bool false

# Disable new window animations
#defaults write NSGlobalDomain NSAutomaticWindowAnimationsEnabled -bool NO

# Enable Text Selection in Quick Look Windows
defaults write com.apple.finder QLEnableTextSelection -bool TRUE;killall Finder

# Dock/Expose
# Hot corners
# Possible values:
#  0: no-op
#  2: Mission Control
#  3: Show application windows
#  4: Desktop
#  5: Start screen saver
#  6: Disable screen saver
#  7: Dashboard
# 10: Put display to sleep
# 11: Launchpad
# 12: Notification Center
# Top left screen corner → No screensaver
defaults write com.apple.dock wvous-tl-corner -int 6
defaults write com.apple.dock wvous-tl-modifier -int 0
# Top right screen corner → Mission Control
# defaults write com.apple.dock wvous-tr-corner -int 2
# defaults write com.apple.dock wvous-tr-modifier -int 0
# Bottom left screen corner → Application windows
# defaults write com.apple.dock wvous-bl-corner -int 3
# defaults write com.apple.dock wvous-bl-modifier -int 0
# Bottom right screen corner → Notification Center
# defaults write com.apple.dock wvous-br-corner -int 12
# defaults write com.apple.dock wvous-br-modifier -int 0

# Automatically hide and show the Dock
defaults write com.apple.dock autohide -bool true

# Use plain text mode for new TextEdit documents
defaults write com.apple.TextEdit RichText -int 0
# Open and save files as UTF-8 in TextEdit
defaults write com.apple.TextEdit PlainTextEncoding -int 4
defaults write com.apple.TextEdit PlainTextEncodingForWrite -int 4

# Use the system-native print preview dialog
defaults write com.google.Chrome DisablePrintPreview -bool true
defaults write com.google.Chrome.canary DisablePrintPreview -bool true

# Don’t display the annoying prompt when quitting iTerm
defaults write com.googlecode.iterm2 PromptOnQuit -bool false

# Sort contacts by first name, then last name
defaults write com.apple.AddressBook ABNameSortingFormat -string "sortingFirstName sortingLastName"

# Kill all affected apps (except Safari, because it's annoying to close that one)
for app in "cfprefsd" "Dock" "Finder" "Mail" "Kaleidoscope" "Tower" "SystemUIServer"; do
	killall "${app}" > /dev/null 2>&1
done

# Don't warn when changing file extensions
defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false

# Show all file extensions
defaults write NSGlobalDomain AppleShowAllExtensions -bool true

### Third Party Apps

# iTerm2

defaults write com.googlecode.iterm2 OnlyWhenMoreTabs -int 0

# Kaleidoscope

defaults write com.blackpixel.kaleidoscope KSIgnoreWhitespaceUserDefaultsKey -int 1

# Jumpcut
# Set shortcut to Command + Shift + v
# See # https://github.com/Hammerspoon/hammerspoon/issues/1021 for details
defaults write net.sf.Jumpcut "ShortcutRecorder mainHotkey" '{ keyCode = 9; modifierFlags = 1179648; }'
defaults write net.sf.Jumpcut "rememberNum" -int 90
defaults write net.sf.Jumpcut "displayNum" -int 10

# Postgres.app

defaults write com.postgresapp.Postgres2 ClientAppName -string "iTerm"

