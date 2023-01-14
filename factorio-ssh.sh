#!/bin/bash
export SSH_PASSWORD=factorio
export SSH_HOST=${SSH_HOST:-localhost}
export SSH_PORT=${SSH_PORT:-2222}
if [ "$1" = "--version" ]; then
    sshpass -p${SSH_PASSWORD} ssh -t -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null -o GlobalKnownHostsFile=/dev/null factorio_version@${SSH_HOST} -p ${SSH_PORT}
    exit $?
fi
if [ "$1" = "--create" ]; then
    sshpass -p${SSH_PASSWORD} ssh -t -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null -o GlobalKnownHostsFile=/dev/null factorio_create_save@${SSH_HOST} -p ${SSH_PORT} factorio "$@"
    exit $?
fi
sshpass -p${SSH_PASSWORD} ssh -t -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null -o GlobalKnownHostsFile=/dev/null factorio@${SSH_HOST} -p ${SSH_PORT}
exit $?
