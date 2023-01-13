#!/bin/ash

if [[ -z ${PASSWORD+x} ]]; then
    echo "use default password"
else
    echo "root:${PASSWORD}" | chpasswd
    echo "factorio:${PASSWORD}" | chpasswd
fi

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
 