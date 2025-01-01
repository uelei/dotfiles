###############################################################################
# General                                                                     #
###############################################################################

####echo "Add some Finnish localization"
####defaults write NSGlobalDomain AppleLocale -string "fi_FI"
####defaults write NSGlobalDomain AppleMeasurementUnits -string "Centimeters"
####defaults write NSGlobalDomain AppleMetricUnits -bool true

####echo "Setup computer name"
####sudo scutil --set ComputerName "uelei-macbook"
####sudo scutil --set HostName "uelei-macbook"
####sudo scutil --set LocalHostName "uelei-macbook"
####sudo defaults write /Library/Preferences/SystemConfiguration/com.apple.smb.server NetBIOSName -string "uelei-macbook"

echo "Disable the 'Are you sure you want to open this application?' dialog"
defaults write com.apple.LaunchServices LSQuarantine -bool false

# echo "Disable Notification Center and remove the menu bar icon"
# launchctl unload -w /System/Library/LaunchAgents/com.apple.notificationcenterui.plist

# echo "Disable auto-correct"
####defaults write NSGlobalDomain NSAutomaticSpellingCorrectionEnabled -bool false

echo "Show percentage in battery status"
defaults write com.apple.menuextra.battery ShowPercent -string "YES"
# defaults write com.apple.menuextra.battery ShowTime -string "NO"

echo "Fix fonth smoothing"
defaults -currentHost write -globalDomain AppleFontSmoothing -int 0

echo "Enable repeat on keydown"
defaults write -g ApplePressAndHoldEnabled -bool false

echo "Use current directory as default search scope in Finder"
defaults write com.apple.finder FXDefaultSearchScope -string "SCcf"

echo "Show Path bar in Finder"
defaults write com.apple.finder ShowPathbar -bool true

# echo "Show Status bar in Finder"
# defaults write com.apple.finder ShowStatusBar -bool true

# normal minimum is 15 (225 ms)
defaults write -g InitialKeyRepeat -float 12.0

echo "Set a shorter Delay until key repeat"
defaults write NSGlobalDomain InitialKeyRepeat -float 10.0

echo "Set a blazingly fast keyboard repeat rate"
# normal minimum is 2 (30 ms)
defaults write NSGlobalDomain KeyRepeat -float 1.9
defaults write -g KeyRepeat -float 1.9

echo "Show the ~/Library folder"
chflags nohidden ~/Library

# echo "Disable rubberband scrolling"
####defaults write -g NSScrollViewRubberbanding -bool false

# echo "Disable dashboard"
####defaults write com.apple.dashboard mcx-disabled -boolean YES

# echo "Move dock to left side of screen"
####defaults write com.apple.dock orientation -string left

# echo "Hide dock automatically"
####defaults write com.apple.dock autohide -boolean true

# I actually didn't get this working.. ideas?
# echo "Set Dock auto-hide delay"
####defaults write com.apple.dock autohide-delay 0

echo "Show all filename extensions in Finder"
defaults write NSGlobalDomain AppleShowAllExtensions -bool true

echo "Expand save panel by default"
defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode -bool true

echo "Expand print panel by default"
defaults write NSGlobalDomain PMPrintingExpandedStateForPrint -bool true

echo "Avoid creating .DS_Store files on network volumes"
defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true

echo "Disable the warning when changing a file extension"
defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false

echo "Require password after a minute after sleep or screen saver begins"
defaults write com.apple.screensaver askForPassword -int 1
defaults write com.apple.screensaver askForPasswordDelay -int 60

# echo "Use list view in all Finder windows by default"
# echo "Four-letter codes for the other view modes: icnv, Nlmv, Flwv"
# defaults write com.apple.finder FXPreferredViewStyle -string "Nlmv"

echo "Remove default text from basic screen saver"
defaults write ~/Library/Preferences/com.apple.ScreenSaver.Basic MESSAGE " "

# echo "Disable sound effect when changing volume"
# defaults write -g com.apple.sound.beep.feedback -integer 0

# echo "Disable user interface sound effects"
####defaults write com.apple.systemsound 'com.apple.sound.uiaudio.enabled' -int 0

# echo "Set system sounds volume to 0"
####defaults write com.apple.systemsound com.apple.sound.beep.volume -float 0

###############################################################################
# Trackpad, Mouse, Keyboard, Gestures                                         #
###############################################################################

# echo "Enable tap to click (Trackpad)"
####defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -bool true
####defaults -currentHost write NSGlobalDomain com.apple.mouse.tapBehavior -int 1
####defaults write NSGlobalDomain com.apple.mouse.tapBehavior -int 1

# echo "Use scroll gesture with the Ctrl (^) modifier key to zoom"
####defaults write com.apple.universalaccess closeViewScrollWheelToggle -bool true
####defaults write com.apple.universalaccess HIDScrollZoomModifierMask -int 262144

# echo "Follow mouse when zoomed in"
####defaults write com.apple.universalaccess closeViewPanningMode -int 0

# echo "Enable full keyboard access for all controls (e.g. enable Tab in modal dialogs)"
####defaults write NSGlobalDomain AppleKeyboardUIMode -int 3

# echo "Tap with two fingers to emulate right click"
####defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadRightClick -bool true

# echo "Disable three finger drag"
####defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadThreeFingerDrag -bool false

# echo "Disable automatic rearrangement of spaces based on most recent usage"
####defaults write com.apple.dock mru-spaces -bool false

# For reference
# echo "Save screenshots to the desktop"
# defaults write com.apple.screencapture location -string "$HOME/Desktop"

###############################################################################
# Activity monitor                                                            #
###############################################################################

echo "Sort Activity Monitor results by CPU usage"
defaults write com.apple.ActivityMonitor SortColumn -string "CPUUsage"
defaults write com.apple.ActivityMonitor SortDirection -int 0


echo "Kill affected applications, so the changes apply"
for app in Safari Finder Dock Mail SystemUIServer; do killall "$app" >/dev/null 2>&1; done
