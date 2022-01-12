openFirefoxTab() { /Applications/Firefox.app/Contents/MacOS/firefox -new-tab $1 }

alert() { osascript -e "display notification \"$1\"" }