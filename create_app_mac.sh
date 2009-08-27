#!/bin/sh
# Force Bourne shell in case tcsh is default.
#
# Author: Phil Hess
# Revisions: 2007-03-17 - initial release.
#            2007-04-09 - added support for .icns file.
#
exename=$1
appname=$2
if [ "$appname" = "" ]
then
  appname=$exename
fi
appfolder=$appname.app
plistfile=$appfolder/Contents/Info.plist
#
if [ "$exename" = "" ]
then
  echo "Usage: $0 executable_file [app_name]"
  echo "Creates .app bundle (folder) for specified executable file"
elif ! [ -e $exename ]
then
  echo "$exename does not exist"
elif [ -e "$appfolder" ]
then
  echo "$appfolder already exists"
else
  echo "Creating $appfolder..."
  mkdir "$appfolder"
  mkdir "$appfolder/Contents"
  mkdir "$appfolder/Contents/MacOS"
  mkdir "$appfolder/Contents/Resources"
#
# Instead of copying executable into .app folder after each compile,
# simply create a symbolic link to executable.
# Tip: When you're ready to distribute your .app, delete the link
# and copy the executable into the .app folder.
  cp -p $exename "$appfolder/Contents/MacOS/$exename"
#
# Create PkgInfo file using first 4 chars of application name.
  echo "APPL"${appname:0:4} >$appfolder/Contents/PkgInfo
#
# If it exists, copy icons file with same name.
  if [ -e "$exename.icns" ]
  then
    cp -p $exename.icns "$appfolder/Contents/Resources"
  fi
#
# Create information property list file (Info.plist).
# Tip: By customizing this script for a specific app, you can set
# additional properties such as CFBundleGetInfoString for copyright
# info, CFBundleIconFile for name of icon file (.icns) in Resources,
# and CFBundleIdentifier (example: com.myorganization.myapp), as well
# as more precise CFBundleSignature (change PkgInfo file too) and 
# CFBundleVersion strings.
  echo '<?xml version="1.0" encoding="UTF-8"?>' >$plistfile
  echo '<!DOCTYPE plist PUBLIC "-//Apple Computer//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">' >>$plistfile
  echo '<plist version="1.0">' >>$plistfile
  echo '<dict>' >>$plistfile
  echo '  <key>CFBundleDevelopmentRegion</key>' >>$plistfile
  echo '  <string>English</string>' >>$plistfile
  echo '  <key>CFBundleExecutable</key>' >>$plistfile
  echo '  <string>'$exename'</string>' >>$plistfile
  if [ -e "$exename.icns" ]
  then
    echo '  <key>CFBundleIconFile</key>' >>$plistfile
    echo '  <string>'$exename'.icns</string>' >>$plistfile
  fi
  echo '  <key>CFBundleInfoDictionaryVersion</key>' >>$plistfile
  echo '  <string>6.0</string>' >>$plistfile
  echo '  <key>CFBundleName</key>' >>$plistfile
  echo '  <string>'$appname'</string>' >>$plistfile
  echo '  <key>CFBundlePackageType</key>' >>$plistfile
  echo '  <string>APPL</string>' >>$plistfile
  echo '  <key>CFBundleSignature</key>' >>$plistfile
  echo '  <string>'${appname:0:4}'</string>' >>$plistfile
  echo '  <key>CFBundleVersion</key>' >>$plistfile
  echo '  <string>1.0</string>' >>$plistfile
  echo '  <key>CSResourcesFileMapped</key>' >>$plistfile
  echo '  <true/>' >>$plistfile
  echo '</dict>' >>$plistfile
  echo '</plist>' >>$plistfile
fi
