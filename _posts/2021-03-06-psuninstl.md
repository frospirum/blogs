---
title: Uninstall Using Powershell
tags: technique
show_edit_on_github: false
modify_date: 2021-03-06
---

论如何干掉预置应用

<!--more-->

*Powershell应以管理员权限运行*

uninstall Chromium Edge[^1]

`.\setup.exe --uninstall --system-level --verbose-logging --force-uninstall`

uninstall 3D Builder：

`get-appxpackage -allusers *3dbuilder* | remove-appxpackage`

uninstall Alarms & Clock：

`get-appxpackage -allusers *alarms* | remove-appxpackage`

uninstall App Connector：

`get-appxpackage -allusers *appconnector* | remove-appxpackage`

uninstall App Installer：

`get-appxpackage -allusers *appinstaller* | remove-appxpackage`

uninstall Calendar and Mail：

`get-appxpackage -allusers *communicationsapps* | remove-appxpackage`

uninstall Calculator：

`get-appxpackage -allusers *calculator* | remove-appxpackage`

uninstall Camera：

`get-appxpackage -allusers *camera* | remove-appxpackage`

uninstall Feedback Hub：

`get-appxpackage -allusers *feedback* | remove-appxpackage`

uninstall Get Help：

`get-appxpackage -allusers *gethelp* | remove-appxpackage`

uninstall Get Office：

`get-appxpackage -allusers *officehub* | remove-appxpackage`

uninstall Get Started or Tips：

`get-appxpackage -allusers *getstarted* | remove-appxpackage`

uninstall Get Skype：

`get-appxpackage -allusers *skypeapp* | remove-appxpackage`

uninstall Groove Music：

`get-appxpackage -allusers *zunemusic* | remove-appxpackage`

uninstall Groove Music and Movies & TV：

`get-appxpackage -allusers *zune* | remove-appxpackage`

uninstall Maps：

`get-appxpackage -allusers *maps* | remove-appxpackage`

uninstall Messaging and Skype Video：

`get-appxpackage -allusers *messaging* | remove-appxpackage`

uninstall Microsoft Solitaire Collection：

`get-appxpackage -allusers *solitaire* | remove-appxpackage`

uninstall Microsoft Wallet：

`get-appxpackage -allusers *wallet* | remove-appxpackage`

uninstall Microsoft Wi-Fi：

`get-appxpackage -allusers *connectivitystore* | remove-appxpackage`

uninstall Money：

`get-appxpackage -allusers *bingfinance* | remove-appxpackage`

uninstall Money, News, Sports and Weather：

`get-appxpackage -allusers *bing* | remove-appxpackage`

uninstall Movies & TV：

`get-appxpackage -allusers *zunevideo* | remove-appxpackage`

uninstall News：

`get-appxpackage -allusers *bingnews* | remove-appxpackage`

uninstall OneNote：

`get-appxpackage -allusers *onenote* | remove-appxpackage`

uninstall Paid Wi-Fi & Cellular：

`get-appxpackage -allusers *oneconnect* | remove-appxpackage`

uninstall Paint 3D：

`get-appxpackage -allusers *mspaint* | remove-appxpackage`

uninstall People：

`get-appxpackage -allusers *people* | remove-appxpackage`

uninstall Phone：

`get-appxpackage -allusers *commsphone* | remove-appxpackage`

uninstall Phone Companion：

`get-appxpackage -allusers *windowsphone* | remove-appxpackage`

uninstall Phone and Phone Companion：

`get-appxpackage -allusers *phone* | remove-appxpackage`

uninstall Photos：

`get-appxpackage -allusers *photos* | remove-appxpackage`

uninstall Sports：

`get-appxpackage -allusers *bingsports* | remove-appxpackage`

uninstall Sticky Notes：

`get-appxpackage -allusers *sticky* | remove-appxpackage`

uninstall Sway：

`get-appxpackage -allusers *sway* | remove-appxpackage`

uninstall View 3D：

`get-appxpackage -allusers *3d* | remove-appxpackage`

uninstall Soundrecorder：

`get-appxpackage -allusers *soundrecorder* | remove-appxpackage`

uninstall Weather：

`get-appxpackage -allusers *bingweather* | remove-appxpackage`

uninstall Windows Holographic：

`get-appxpackage -allusers *holographic* | remove-appxpackage`

uninstall Microsoft Store：

`get-appxpackage -allusers *windowsstore* | remove-appxpackage`

uninstall Xbox：

`get-appxpackage -allusers *xbox* | remove-appxpackage`

[^1]:该命令应在Chromium Edge的setup.exe所在目录下执行，路径由版本号决定，一般为 C:\Program Files (x86)\Microsoft\Edge\Application\\*edgeversion*\Installer
