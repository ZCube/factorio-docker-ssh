#!/bin/bash
cd /factorio
echo ${SSH_ORIGINAL_COMMAND}
params=( $SSH_ORIGINAL_COMMAND )
/opt/factorio/bin/x64/factorio --create ${params[2]}
