# factorio-docker-ssh

## factorio-docker + sshd

* The Factorio Docker SSH image is a Docker image that runs the OpenSSH server and makes only Factorio executable using ForceCommand.

* [Factorio Server Manager](https://github.com/OpenFactorioServerManager/factorio-server-manager) or [FactoCord](https://github.com/FactoKit/FactoCord) manages the process directly. This is necessary for save file management, loading, and mod settings. However, writing a dedicated Factorio Docker for this is not easy and difficult to maintain.

## Usage

* Replace the Factorio execution path with the path of the ssh connection script
* Set up the volume so that the /factorio path is shared by the management tools and factorio-docker-ssh
* Default Password : factorio
* Password can be changed by setting the PASSWORD environment variable.

## Minimal Demo

```
$ docker run --rm -ti -p 2222:2222 ghcr.io/zcube/factorio-docker-ssh:latest &
use default password

$ ssh -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null -o GlobalKnownHostsFile=/dev/null root@localhost -p 2222
Warning: Permanently added '[localhost]:2222' (ED25519) to the list of known hosts.
root@localhost's password: 
PTY allocation request failed on channel 0
+ FACTORIO_VOL=/factorio
+ LOAD_LATEST_SAVE=true
+ GENERATE_NEW_SAVE=false
+ SAVE_NAME=
+ BIND=
+ mkdir -p /factorio
+ mkdir -p /factorio/saves
+ mkdir -p /factorio/config
+ mkdir -p /factorio/mods
+ mkdir -p /factorio/scenarios
+ mkdir -p /factorio/script-output
+ [[ ! -f /factorio/config/rconpw ]]
+ pwgen 15 1
+ [[ ! -f /factorio/config/server-settings.json ]]
+ cp /opt/factorio/data/server-settings.example.json /factorio/config/server-settings.json
+ [[ ! -f /factorio/config/map-gen-settings.json ]]
+ cp /opt/factorio/data/map-gen-settings.example.json /factorio/config/map-gen-settings.json
+ [[ ! -f /factorio/config/map-settings.json ]]
+ cp /opt/factorio/data/map-settings.example.json /factorio/config/map-settings.json
++ find -L /factorio/saves -iname '*.tmp.zip' -mindepth 1
++ wc -l
+ NRTMPSAVES=0
+ [[ 0 -gt 0 ]]
+ [[ '' == \t\r\u\e ]]
++ id -u
+ [[ 0 = 0 ]]
+ usermod -o -u 845 factorio
usermod: no changes
+ groupmod -o -g 845 factorio
+ chown -R factorio:factorio /factorio
+ SU_EXEC='su-exec factorio'
+ sed -i '/write-data=/c\write-data=\/factorio/' /opt/factorio/config/config.ini
++ find -L /factorio/saves -iname '*.zip' -mindepth 1
++ wc -l
+ NRSAVES=0
+ [[ false != true ]]
+ [[ 0 == 0 ]]
+ GENERATE_NEW_SAVE=true
+ SAVE_NAME=_autosave1
+ [[ true == true ]]
+ [[ -z _autosave1 ]]
+ [[ -f /factorio/saves/_autosave1.zip ]]
+ su-exec factorio /opt/factorio/bin/x64/factorio --create /factorio/saves/_autosave1.zip --map-gen-settings /factorio/config/map-gen-settings.json --map-settings /factorio/config/map-settings.json
   0.000 2023-01-14 00:08:29; Factorio 1.1.76 (build 60350, linux64, headless)
   0.000 Operating system: Linux
   0.000 Program arguments: "/opt/factorio/bin/x64/factorio" "--create" "/factorio/saves/_autosave1.zip" "--map-gen-settings" "/factorio/config/map-gen-settings.json" "--map-settings" "/factorio/config/map-settings.json" 
   0.000 Config path: /opt/factorio/config/config.ini
   0.000 Read data path: /opt/factorio/data
   0.000 Write data path: /factorio [17696/59767MB]
   0.000 Binaries path: /opt/factorio/bin
   0.007 System info: [CPU: Intel(R) Core(TM) i7-8700B CPU @ 3.20GHz, 6 cores, RAM: 7859 MB]
   0.007 Environment: DISPLAY=<unset> WAYLAND_DISPLAY=<unset> DESKTOP_SESSION=<unset> XDG_SESSION_DESKTOP=<unset> XDG_CURRENT_DESKTOP=<unset> __GL_FSAA_MODE=<unset> __GL_LOG_MAX_ANISO=<unset> __GL_SYNC_TO_VBLANK=<unset> __GL_SORT_FBCONFIGS=<unset> __GL_YIELD=<unset>
   0.007 Running in headless mode
   0.012 Loading mod core 0.0.0 (data.lua)
   0.037 Loading mod base 1.1.76 (data.lua)
   0.222 Loading mod base 1.1.76 (data-updates.lua)
   0.306 Checksum for core: 870127790
   0.306 Checksum of base: 3065294274
   0.524 Prototype list checksum: 3034860339
   0.574 Info PlayerData.cpp:73: Local player-data.json unavailable
   0.574 Info PlayerData.cpp:78: Cloud player-data.json unavailable
   0.575 Factorio initialised
   0.576 Info Main.cpp:745: Creating new map /factorio/saves/_autosave1.zip
   1.207 Loading level.dat: 989446 bytes.
   1.207 Info Scenario.cpp:199: Map version 1.1.76-0
   1.229 Checksum for script /factorio/temp/currently-playing/control.lua: 2881393120
Done.
   1.340 Goodbye
+ FLAGS=(--port "$PORT" --server-settings "$CONFIG/server-settings.json" --server-banlist "$CONFIG/server-banlist.json" --rcon-port "$RCON_PORT" --server-whitelist "$CONFIG/server-whitelist.json" --use-server-whitelist --server-adminlist "$CONFIG/server-adminlist.json" --rcon-password "$(cat "$CONFIG/rconpw")" --server-id /factorio/config/server-id.json)
++ cat /factorio/config/rconpw
+ '[' -n '' ']'
+ [[ true == true ]]
+ FLAGS+=(--start-server-load-latest)
+ exec su-exec factorio /opt/factorio/bin/x64/factorio --port 34197 --server-settings /factorio/config/server-settings.json --server-banlist /factorio/config/server-banlist.json --rcon-port 27015 --server-whitelist /factorio/config/server-whitelist.json --use-server-whitelist --server-adminlist /factorio/config/server-adminlist.json --rcon-password ibee9pae6yaegaN --server-id /factorio/config/server-id.json --start-server-load-latest
   0.000 2023-01-14 00:08:30; Factorio 1.1.76 (build 60350, linux64, headless)
   0.000 Operating system: Linux
   0.000 Program arguments: "/opt/factorio/bin/x64/factorio" "--port" "34197" "--server-settings" "/factorio/config/server-settings.json" "--server-banlist" "/factorio/config/server-banlist.json" "--rcon-port" "27015" "--server-whitelist" "/factorio/config/server-whitelist.json" "--use-server-whitelist" "--server-adminlist" "/factorio/config/server-adminlist.json" "--rcon-password" <private> "--server-id" "/factorio/config/server-id.json" "--start-server-load-latest" 
   0.000 Config path: /opt/factorio/config/config.ini
   0.000 Read data path: /opt/factorio/data
   0.000 Write data path: /factorio [17695/59767MB]
   0.000 Binaries path: /opt/factorio/bin
   0.006 System info: [CPU: Intel(R) Core(TM) i7-8700B CPU @ 3.20GHz, 6 cores, RAM: 7859 MB]
   0.006 Environment: DISPLAY=<unset> WAYLAND_DISPLAY=<unset> DESKTOP_SESSION=<unset> XDG_SESSION_DESKTOP=<unset> XDG_CURRENT_DESKTOP=<unset> __GL_FSAA_MODE=<unset> __GL_LOG_MAX_ANISO=<unset> __GL_SYNC_TO_VBLANK=<unset> __GL_SORT_FBCONFIGS=<unset> __GL_YIELD=<unset>
   0.006 Running in headless mode
   0.011 Loading mod core 0.0.0 (data.lua)
   0.048 Loading mod base 1.1.76 (data.lua)
   0.237 Loading mod base 1.1.76 (data-updates.lua)
   0.326 Checksum for core: 870127790
   0.326 Checksum of base: 3065294274
   0.550 Prototype list checksum: 3034860339
   0.599 Info PlayerData.cpp:71: Local player-data.json available, timestamp 1673654910
```
