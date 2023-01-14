#!/bin/ash
set -eoux pipefail

FACTORIO_VOL=/factorio
LOAD_LATEST_SAVE="${LOAD_LATEST_SAVE:-true}"
GENERATE_NEW_SAVE="${GENERATE_NEW_SAVE:-false}"
SAVE_NAME="${SAVE_NAME:-""}"
UPDATE_MODS_ON_START="${UPDATE_MODS_ON_START:-}"
BIND="${BIND:-""}"
TOKEN="${TOKEN:-""}"
USERNAME="${TOKEN:-""}"

mkdir -p $CONFIG

if [[ -z ${SSH_ASSWORD+x} ]]; then
    echo "use default password"
else
    echo "root:${SSH_ASSWORD}" | chpasswd
    echo "factorio:${SSH_ASSWORD}" | chpasswd
    echo "factorio_version:${SSH_ASSWORD}" | chpasswd
    echo "factorio_basemod_info:${SSH_ASSWORD}" | chpasswd
    echo "factorio_create_save:${SSH_ASSWORD}" | chpasswd
fi

if [[ ! -f $CONFIG/rconpw ]]; then
  pwgen 15 1 >"$CONFIG/rconpw"
fi

if [[ ! -f $CONFIG/config.ini ]]; then
  cp /opt/factorio/config/config.ini.original $CONFIG/config.ini
fi


if [[ $(id -u) = 0 ]]; then
  usermod -o -u "$PUID" factorio
  usermod -o -u "$PUID" factorio_version
  usermod -o -u "$PUID" factorio_create_save
  usermod -o -u "$PUID" factorio_basemod_info
  groupmod -o -g "$PGID" factorio
  chown -R factorio:factorio "$FACTORIO_VOL"
fi

mkdir -p /factorio/data/base
cp /opt/factorio/data/base/info.json /factorio/data/base/info.json
cp /opt/factorio/data/*.example.json /factorio/data/

cp /factorio-ssh.sh /factorio/factorio-ssh.sh

/usr/sbin/sshd -D -o \
    "SetEnv=GENERATE_NEW_SAVE=${GENERATE_NEW_SAVE} \
    LOAD_LATEST_SAVE=${LOAD_LATEST_SAVE} \
    PORT=${PORT} \
    BIND=${BIND} \
    RCON_PORT=${RCON_PORT} \
    SAVE_NAME=${SAVE_NAME} \
    TOKEN=${TOKEN} \
    UPDATE_MODS_ON_START=${UPDATE_MODS_ON_START} \
    USERNAME=${USERNAME} \
    SAVES=${SAVES} \
    CONFIG=${CONFIG} \
    MODS=${MODS} \
    SCENARIOS=${SCENARIOS} \
    SCRIPTOUTPUT=${SCRIPTOUTPUT} \
    PUID=${PUID} \
    PGID=${PGID}"
 