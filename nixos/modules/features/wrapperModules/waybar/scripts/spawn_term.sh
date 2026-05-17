#! /usr/bin/env bash
#
# Usage: spawn_term.sh <module>
#
# Arguments:
#   <module>
#           Module name as css identifier without '#' (i.e. 'niri-workspaces')

set -euo pipefail

spawn_term() {
  local cmd="${1}"
  local pos="${2}"

  foot --title "${cmd} from-waybar" --app-id "foot-floating-to-${pos}" ${cmd}
}

main() {
  if [ "$#" -ne 1 ]; then
    return 2
  fi

  local module="${1}"

  case ${module} in
  "mpris")
    spawn_term rmpc left
    ;;
  "bluetooth")
    spawn_term bluetui bottom-left
    ;;
  "wireplumber")
    spawn_term wiremix bottom-left
    ;;
  "network")
    spawn_term impala bottom-left
    ;;
  "cpu")
    spawn_term btm bottom-left
    ;;
  *)
    return 3
    ;;
  esac
}

main "${@}"
