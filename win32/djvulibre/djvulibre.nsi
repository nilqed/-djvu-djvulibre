; Script generated by the HM NIS Edit Script Wizard.

; HM NIS Edit Wizard helper defines
!define PRODUCT_NAME "DjVuLibre+DjView"
!define PRODUCT_VERSION "3.5.24+4.8"
!define PRODUCT_PUBLISHER "DjVuZone"
!define PRODUCT_WEB_SITE "http://djvu.sourceforge.net"
!define PRODUCT_DIR_REGKEY "Software\Microsoft\Windows\CurrentVersion\App Paths\djview.exe"
!define PRODUCT_UNINST_KEY "Software\Microsoft\Windows\CurrentVersion\Uninstall\${PRODUCT_NAME}"
!define PRODUCT_UNINST_ROOT_KEY "HKLM"

SetCompressor bzip2

; MUI 1.67 compatible ------
!include "MUI.nsh"

; MUI Settings
!define MUI_ABORTWARNING
!define MUI_ICON "${NSISDIR}\Contrib\Graphics\Icons\modern-install.ico"
!define MUI_UNICON "${NSISDIR}\Contrib\Graphics\Icons\modern-uninstall.ico"

; Welcome page
!insertmacro MUI_PAGE_WELCOME
; License page
!insertmacro MUI_PAGE_LICENSE "..\djvulibre-3.5\COPYING"
; Directory page
!insertmacro MUI_PAGE_DIRECTORY
; Instfiles page
!insertmacro MUI_PAGE_INSTFILES
; Finish page
; !define MUI_FINISHPAGE_SHOWREADME "$INSTDIR\README.txt"
!insertmacro MUI_PAGE_FINISH

; Uninstaller pages
!insertmacro MUI_UNPAGE_INSTFILES

; Language files
!insertmacro MUI_LANGUAGE "English"

; Reserve files
!insertmacro MUI_RESERVEFILE_INSTALLOPTIONS

; MUI end ------

Name "${PRODUCT_NAME} ${PRODUCT_VERSION}"
OutFile "..\${PRODUCT_NAME}-${PRODUCT_VERSION}-Setup.exe"
InstallDir "$PROGRAMFILES\DjVuZone\DjVuLibre"
InstallDirRegKey HKLM "${PRODUCT_DIR_REGKEY}" ""
ShowInstDetails show
ShowUnInstDetails show

Section "MainSection" SEC01
  SetOutPath "$INSTDIR"
  SetOverwrite try
  File "*.exe"
  File "*.dll"
  File "*.lib"
  File /r "include"
  File /r "man"
  File /r "plugins"
  File /r "share"
  File "qt.conf"
  File "djvulibre.nsi"
  WriteIniStr "$INSTDIR\${PRODUCT_NAME}.url" "InternetShortcut" "URL" "${PRODUCT_WEB_SITE}"
  CreateShortCut "$DESKTOP\DjView.lnk" "$INSTDIR\djview.exe"
  CreateShortCut "$SMPROGRAMS\DjVuLibre\Website.lnk" "$INSTDIR\${PRODUCT_NAME}.url"
  CreateShortCut "$SMPROGRAMS\DjVuLibre\Documentation.lnk" "$INSTDIR\man"
  CreateShortCut "$SMPROGRAMS\DjVuLibre\Uninstall.lnk" "$INSTDIR\uninst.exe"
  CreateDirectory "$SMPROGRAMS\DjVuLibre"
  CreateShortCut "$SMPROGRAMS\DjVuLibre\DjView.lnk" "$INSTDIR\djview.exe"
SectionEnd

Section -Post
  WriteUninstaller "$INSTDIR\uninst.exe"
  WriteRegStr HKLM "${PRODUCT_DIR_REGKEY}" "" "$INSTDIR\djview.exe"
  WriteRegStr ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}" "DisplayName" "${PRODUCT_NAME}"
  WriteRegStr ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}" "UninstallString" "$INSTDIR\uninst.exe"
  WriteRegStr ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}" "DisplayIcon" "$INSTDIR\djview.exe"
  WriteRegStr ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}" "DisplayVersion" "${PRODUCT_VERSION}"
  WriteRegStr ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}" "URLInfoAbout" "${PRODUCT_WEB_SITE}"
  WriteRegStr ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}" "Publisher" "${PRODUCT_PUBLISHER}"
  DeleteRegKey HKCR "DjVu.Document"
  DeleteRegKey HKCR ".djvu"
  DeleteRegKey HKCR ".djv"
  WriteRegStr HKCR ".djvu" "" "DjVu.Document"
  WriteRegStr HKCR ".djv" "" "DjVu.Document"
  WriteRegStr HKCR "DjVu.Document" "" "DjVu Document"
  WriteRegStr HKCR "DjVu.Document\DefaultIcon" "" "$INSTDIR\djview.exe,1"
  WriteRegStr HKCR "DjVu.Document\shell\open\command" "" '"$INSTDIR\djview.exe" "%1"'
SectionEnd

Function un.onUninstSuccess
  HideWindow
  MessageBox MB_ICONINFORMATION|MB_OK "$(^Name) was successfully removed from your computer."
FunctionEnd

Function un.onInit
  MessageBox MB_ICONQUESTION|MB_YESNO|MB_DEFBUTTON2 "Are you sure you want to completely remove $(^Name) and all of its components?" IDYES +2
  Abort
FunctionEnd

Section Uninstall
  RMDir /r /REBOOTOK "$INSTDIR"
  RMDir /r /REBOOTOK "$SMPROGRAMS\DjVuLibre"
  Delete "$DESKTOP\DjView.lnk"
  DeleteRegKey ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}"
  DeleteRegKey HKLM "${PRODUCT_DIR_REGKEY}"
  DeleteRegKey HKCR "DjVu.Document"
  DeleteRegKey HKCR ".djvu"
  DeleteRegKey HKCR ".djv"
  SetAutoClose true
SectionEnd
