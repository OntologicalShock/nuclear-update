#!/bin/bash

# Author: Justin E. Davis
# Created: 06-Dec-2024
# Last Modified: 23-Dec-2024

# Description:
# First this script updates apt software repos and updates all available packages.
# Then it updates flatpak, homebrew, oh-my-posh, colorls, etc.
# All the while it formats the output to stylistrically match the oh-my-posh theme nuclear-nord.omp.json

# Create a variable that will inform the /fold/ command later by passing the current terminal
# columns to bc to calculate 80% width with no decimals.
terminalWidth=$(echo "scale=0; $(tput cols) * 0.8 / 1" | bc)

# Define some human readable names for terminal colors
mainColorB=43 #yellow
mainColorF=33 #yellow
aptColorB=41 #red
aptColorF=31 #red
flatpakColorB=104 #blue
flatpakColorF=94 #blue
ompColorB=45 #purple
ompColorF=35 #purple
white=97 #white foreground

# Request sudo up front so the formatting isn't broken
sudo bash -c "echo ''"

# Preamble# terminalWidth=$(echo "$width" | sed 's/\.$//') #trim away the decimal places
echo -e "\e[${mainColorF}m╭─────\ue0b6\e[1;30;${mainColorB}m\u27f3 Updating APT, Flatpak, Oh-My-Posh\e[0m\e[${mainColorF}m\ue0b4\e[0m\n\e[${mainColorF}m│ \e[0m"

# Update Ubuntu repositories and perform all available upgrades with cleanup at the end.
sudo bash -c "\
	echo -e '\e[${mainColorF}m│\e[0m\e[${aptColorF}m╭────\ue0b6\e[1;${white};${aptColorB}m\u27f3 APT Update\e[0m\e[${aptColorF}m\ue0b4\e[0m'\
		&&
	apt-get update |\
		fold -s -w $terminalWidth |\
		sed 's/^/\x1b[${mainColorF}m│\x1b[0m\x1b[${aptColorF}m│  ∙ \x1b[0m/g'\
		&&
	echo -e '\e[${mainColorF}m│\e[0m\e[${aptColorF}m│    \e[0m\n\e[${mainColorF}m│\e[0m\e[${aptColorF}m├───\ue0b6\e[1;${white};${aptColorB}m\u27f3 APT Dist-Upgrade\e[0m\e[${aptColorF}m\ue0b4\e[0m'\
		&&
	apt-get -y dist-upgrade |\
		fold -s -w $terminalWidth |\
		sed 's/^/\x1b[${mainColorF}m│\x1b[0m\x1b[${aptColorF}m│  ∙ \x1b[0m/g'\
		&&
	echo -e '\e[${mainColorF}m│\e[0m\e[${aptColorF}m│    \e[0m\n\e[${mainColorF}m│\e[0m\e[${aptColorF}m├───\ue0b6\e[1;${white};${aptColorB}m\u27f3 APT Auto-Remove\e[0m\e[${aptColorF}m\ue0b4\e[0m'\
		&&
	apt-get -y autoremove |\
		fold -s -w $terminalWidth |\
		sed 's/^/\x1b[${mainColorF}m│\x1b[0m\x1b[${aptColorF}m│  ∙ \x1b[0m/g'\
		&&
	echo -e '\e[${mainColorF}m│\e[0m\e[${aptColorF}m│    \e[0m\n\e[${mainColorF}m│\e[0m\e[${aptColorF}m├───\ue0b6\e[1;${white};${aptColorB}m\u27f3 APT Clean\e[0m\e[${aptColorF}m\ue0b4\e[0m'\
		&&
	apt-get -y clean |\
		fold -s -w $terminalWidth |\
		sed 's/^/\x1b[${mainColorF}m│\x1b[0m\x1b[${aptColorF}m│  ∙ \x1b[0m/g'\
		&&
	echo -e '\e[${mainColorF}m│\e[0m\e[${aptColorF}m│    \e[0m\n\e[${mainColorF}m│\e[0m\e[${aptColorF}m╰───\ue0b6\e[1;${white};${aptColorB}m\uf05d APT Complete\e[0m\e[${aptColorF}m\ue0b4\e[0m'\
		&&
	echo -e '\e[${mainColorF}m│'"

# Update Flatpaks
sudo bash -c "\
    echo -e '\e[${mainColorF}m│\e[${flatpakColorF}m╭───\ue0b6\e[1;${white};${flatpakColorB}m\u27f3 Flatpak Update\e[0m\e[${flatpakColorF}m\ue0b4\e[0m'\
		&&
    flatpak update -y --noninteractive |\
    	fold -s -w $terminalWidth |\
		sed -r '/^\s*$/d' |\
    	sed 's/^/\x1b[${mainColorF}m│\x1b[0m\x1b[${flatpakColorF}m│  ∙ \x1b[0m/g'\
		&&
	echo -e '\e[${mainColorF}m│\e[0m\e[${flatpakColorF}m│\e[0m'\
		&&
	echo -e '\e[${mainColorF}m│\e[0m\e[${flatpakColorF}m╰───\ue0b6\e[1;${white};${flatpakColorB}m\uf05d Flatpak Complete\e[0m\e[${flatpakColorF}m\ue0b4\e[0m'\
		&&
	echo -e '\e[${mainColorF}m│'"

# Update Oh-My-Posh
bash -c "\
	echo -e '\e[${mainColorF}m│\e[${ompColorF}m╭───\ue0b6\e[1;${white};${ompColorB}m\u27f3 Oh-My-Posh Update\e[0m\e[${ompColorF}m\ue0b4\e[0m'\
		&&
	echo -e '\e[${mainColorF}m│\e[${ompColorF}m│  ∙ \e[0mChecking for updates.'\
		&&
	oh-my-posh upgrade |\
		fold -s -w $terminalWidth |\
		sed 's/^/\x1b[${mainColorF}m│x1b[${ompColorF}m│  ∙ \x1b[0m/g'\
		&&
	echo -e '\e[${mainColorF}m│\e[0m\e[${ompColorF}m│    \e[0m\n\e[${mainColorF}m│\e[0m\e[${ompColorF}m╰───\ue0b6\e[1;${white};${ompColorB}m\uf05d Oh-My-Posh Complete\e[0m\e[${ompColorF}m\ue0b4\e[0m'\
		&&
	echo -e '\e[${mainColorF}m│'"

# Restart the shell
echo -e "\e[${mainColorF}m╰────\ue0b6\e[1;30;${mainColorB}m\uead2 Restarting Bash\e[0m\e[${mainColorF}m\ue0b4\e[0m\n"
exec bash

exit 0