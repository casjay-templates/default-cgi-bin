#!/usr/bin/env sh
# shellcheck shell=sh
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
##@Version           :  202308261653-git
# @@Author           :  Jason Hempstead
# @@Contact          :  jason@casjaysdev.pro
# @@License          :  WTFPL
# @@ReadME           :  install.sh --help
# @@Copyright        :  Copyright: (c) 2023 Jason Hempstead, Casjays Developments
# @@Created          :  Saturday, Aug 26, 2023 16:53 EDT
# @@File             :  install.sh
# @@Description      :  Default web server error pages
# @@Changelog        :  New script
# @@TODO             :  Better documentation
# @@Other            :
# @@Resource         :
# @@Terminal App     :  no
# @@sudo/root        :  no
# @@Template         :  shell/sh
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# shellcheck disable=SC2016
# shellcheck disable=SC2031
# shellcheck disable=SC2120
# shellcheck disable=SC2155
# shellcheck disable=SC2199
# shellcheck disable=SC2317
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
APPNAME="$(basename "$0" 2>/dev/null)"
VERSION="202308261653-git"
RUN_USER="$USER"
SET_UID="$(id -u)"
SCRIPT_SRC_DIR="$(cd "$(dirname "$0")" && pwd)"
DEFAULT_CGI_BIN_CWD="$(realpath "$PWD")"
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# check for command
__cmd_exists() { which $1 >/dev/null 2>&1 || return 1; }
__function_exists() { builtin type $1 >/dev/null 2>&1 || return 1; }
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# custom functions

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# Define variables
DEFAULT_COLOR="254"
DEFAULT_CGI_BIN_EXIT_STATUS=0
WEB_SERVER_CGI_BIN_DIR="/usr/share/httpd/cgi-bin"
SOURCE_GIT_REPO="https://github.com/casjay-templates/default-cgi-bin"
[ -n "$TMP" ] && [ -d "$TMP" ] && TMP_DIR="$TMP/default_cgi_bin_$$" || TMP_DIR="/tmp/default_cgi_bin_$$"
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# Main application
if [ -d "$WEB_SERVER_CGI_BIN_DIR/.git" ]; then
  rm -Rf "$WEB_SERVER_CGI_BIN_DIR"
fi
echo "Installing to $WEB_SERVER_CGI_BIN_DIR"
[ "$USER" = "root" ] && runas_user="" || runas_user="sudo"
$runas_user mkdir -p "$WEB_SERVER_CGI_BIN_DIR"
$runas_user git clone -q "$SOURCE_GIT_REPO" "$TMP_DIR"
$runas_user cp -Rf "$TMP_DIR/." "$WEB_SERVER_CGI_BIN_DIR"
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# End application
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# lets exit with code
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
exit $DEFAULT_CGI_BIN_EXIT_STATUS
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# ex: ts=2 sw=2 et filetype=sh
