#!/usr/bin/env playonLinux-bash

# Date: See changelog.
# Last revision: See changelog.
# Wine version used: See changelog.
# Distribution used to test: See changelog.
# Author: GuerrreroAzul
# Contributor: GuerrreroAzul
# License: GNU General Public License v3.0 

# CHANGELOG
# [GuerrreroAzul] 2024-08-07 09:30 (UTC -06:00) / Wine 9.0 x86 / Linux Mint 22 x86_64 XFCE
# Script creation:
#   Wine version: 9.0
#   System version: Windows 7
#   Architecture: 32bits
# Reference
#   Link download: https://www.bluestacks.com/

[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"

# Declaration of variables
TITLE="BlueStacks 5"
PREFIX="BlueStacks 5"
CATEGORY="Games;"
WINEVERSION="9.0"
OSVERSION="win7"
EDITHOR="GuerrreroAzul"
COMPANY="Now.gg, inc."
HOMEPAGE="https://www.bluestacks.com/"
#LOGO="https://imgur.com/VT1slDj.png"
#BANNER="https://imgur.com/ba7r3Zz.png"

# Setup Image
POL_GetSetupImages "$LOGO" "$BANNER" "$TITLE"

# Starting the script
POL_SetupWindow_Init
POL_Debug_Init

# Welcome message
POL_SetupWindow_presentation "$TITLE" "$COMPANY" "$HOMEPAGE" "$EDITHOR" "$PREFIX"

# PlayOnLinux Version Check
POL_RequiredVersion 4.3.4 || POL_Debug_Fatal "$(eval_gettext 'TITLE wont work with $APPLICATION_TITLE $VERSION\nPlease update!')"

# Check winbind library is installed.
if [ "$POL_OS" = "Linux" ]; then
  wbinfo -V || POL_Debug_Fatal "$(eval_gettext 'Please install winbind before installing.')" "$TITLE!"
fi

# Prepare resources for installation!
POL_Wine_SelectPrefix "$PREFIX"
POL_Wine_PrefixCreate "$WINEVERSION"
Set_OS "$OSVERSION"

#Dependencies
POL_Call POL_Install_d3dx9

# Script start
cd "$HOME"
POL_SetupWindow_browse "$(eval_gettext 'Please select the setup file to run.')" "$TITLE"
INSTALLER="$APP_ANSWER"

# Install Program
POL_Wine start /unix "$INSTALLER"
POL_Wine_WaitExit "$INSTALLER"

# Shortcut
POL_Shortcut "bluestacks.exe" "$TITLE" "" "" "$CATEGORY"

# End script
POL_System_TmpDelete
POL_SetupWindow_Close
exit 0