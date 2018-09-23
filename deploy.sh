#!/usr/bin/env nix-shell
#!nix-shell -i bash -p nixos-secrets
set -eu

usage() {
  echo "$0 [-n] <machine>"
}

rebuild=1 # Whether to rebuild configuration

while getopts "n" opt; do
    case "$opt" in
        n) rebuild=0 ;;
        \?) usage ;;
    esac
done
shift "$(($OPTIND -1))"

# See https://gist.github.com/tvlooy/cbfbdb111a4ebad8b93e
nixos_root="$(dirname $(readlink -f "$0"))"
ssh_control_path="~/.ssh/master-%r@%h:%p.sock"

nixos-secrets check "${nixos_root}/secrets"

ssh_host="${1}"
shift

ssh -fN -oControlMaster=auto -oControlPath="${ssh_control_path}" -oControlPersist=1m "${ssh_host}"

read -sp "[sudo] password for ${USER}: " sudo_password
echo

rsync -e "ssh -oControlPath=\"${ssh_control_path}\"" --rsync-path="echo \"${sudo_password}\" | sudo -Sv 2>/dev/null; sudo rsync" -r --delete "${nixos_root}/" "${ssh_host}:/etc/nixos"

if [ "${rebuild}" -eq 1 ]; then
    ssh -oControlPath=\"${ssh_control_path}\" "${ssh_host}" "echo \"${sudo_password}\" | sudo -Sv 2>/dev/null; sudo nixos-rebuild switch -I nixos-config=/etc/nixos/machines/${ssh_host} -I localpkgs=/etc/nixos $@"
fi
