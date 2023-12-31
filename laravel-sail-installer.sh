#!/bin/bash

options=(
    "mysql"
    "pgsql"
    "mariadb"
    "redis"
    "memcached"
    "milisearch"
    "minio"
    "selenium"
    "mailhog"
)

url="https://laravel.build/"
with=""
usage() {
    echo -e "Laravel Build Script \e[32m@IvoKara/v0.0.4"
    echo ""
    echo -e "\e[33mUsage:\e[0m"
    echo -e "  [command] [options] [arguments]"
    echo ""
    echo -e "\e[33mOptions:"
    echo -e "\e[32m  -w, --with\e[0m    Choose which services should be configured in your new"
    echo -e "\t\tapplication. Available services include \e[1;90mmysql\e[0m, \e[1;90mpgsql\e[0m, \e[1;90mmariadb\e[0m,"
    echo -e "\t\t\e[1;90mredis\e[0m, \e[1;90mmemcached\e[0m, \e[1;90mmeilisearch\e[0m, \e[1;90mminio\e[0m, \e[1;90mselenium\e[0m, and \e[1;90mmailhog\e[0m"
    echo ""
    echo -e "\e[32m  -h, --help\e[0m    Displays this help page"
    echo ""
    echo -e "\e[33mAvailable commands"
    echo -e "\e[32m  new\e[0m            Create a new Laravel application"
    echo -e "\e[32m  devcontainer\e[0m   Instruct Sail to install a default Devcontainer"

    exit 2
}

PARSED=$(getopt -o w:h --long with:,help "$@")
VALID=$?
if [ "$VALID" != "0" ]; then
    usage
fi

eval set -- "$PARSED"

while :; do
    case "$1" in
    -w | --with)
        with="?with=$2"
        shift 2
        ;;
    -h | --help)
        usage
        ;;
    --)
        shift
        break
        ;;
    *)
        echo "Unexpected option $1"
        usage
        ;;
    esac
done

cmd=$1
name=$2

if [ $# -eq 2 ] && [ -n "$cmd" ] && [ -n "$name" ]; then
    case $cmd in
    new)
        # echo "${url}${name}${with}"
        curl -s "${url}${name}${with}" | bash
        ;;
    devcontainer)
        # echo "${url}${name}${with}&devcontainer"
        curl -s "${url}${name}${with}&devcontainer" | bash
        ;;
    *)
        usage
        ;;
    esac
else
    usage
fi
