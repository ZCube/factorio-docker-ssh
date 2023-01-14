# syntax=docker/dockerfile:1.4
ARG FACTORIO_VERSION=latest
FROM factoriotools/factorio:${FACTORIO_VERSION}

ARG PASSWORD=factorio

RUN apk --update add --no-cache openssh sshpass bash \
  && rm -rf /var/cache/apk/*

RUN rm /etc/sshssh/ssh_host_* || true \
 && ssh-keygen -q -N "" -t rsa -b 4096 -f /etc/ssh/ssh_host_key \
 && ssh-keygen -q -N "" -t dsa         -f /etc/ssh/ssh_host_dsa_key \
 && ssh-keygen -q -N "" -t rsa -b 4096 -f /etc/ssh/ssh_host_rsa_key \
 && ssh-keygen -q -N "" -t ecdsa       -f /etc/ssh/ssh_host_ecdsa_key \
 && ssh-keygen -q -N "" -t ed25519     -f /etc/ssh/ssh_host_ed25519_key

RUN cat <<EOF >/etc/ssh/sshd_config_force_command
Match User root
  X11Forwarding no
  AllowTcpForwarding no
  PermitTTY yes
  ForceCommand "/docker-entrypoint.sh"
Match User factorio
  X11Forwarding no
  AllowTcpForwarding no
  PermitTTY yes
  ForceCommand "/docker-entrypoint.sh"
Match User factorio_version
  X11Forwarding no
  AllowTcpForwarding no
  PermitTTY yes
  ForceCommand "/factorio-version.sh"
Match User factorio_basemod_info
  X11Forwarding no
  AllowTcpForwarding no
  PermitTTY yes
  ForceCommand "/factorio-basemod-info.sh"
Match User factorio_create_save
  X11Forwarding no
  AllowTcpForwarding no
  PermitTTY yes
  ForceCommand "/factorio-create-save.sh"
EOF

RUN sed -i s/#PermitRootLogin.*/PermitRootLogin\ yes/ /etc/ssh/sshd_config \
 && cat /etc/ssh/sshd_config_force_command >> /etc/ssh/sshd_config \
 && echo "root:${PASSWORD}" | chpasswd \
 && echo "factorio:${PASSWORD}" | chpasswd \
 && useradd -ou "$PUID" "-g${PGID}" "factorio_version" \
 && useradd -ou "$PUID" "-g${PGID}" "factorio_basemod_info" \
 && useradd -ou "$PUID" "-g${PGID}" "factorio_create_save" \
 && echo "factorio_version:${PASSWORD}" | chpasswd \
 && echo "factorio_basemod_info:${PASSWORD}" | chpasswd \
 && echo "factorio_create_save:${PASSWORD}" | chpasswd \
 && sed -ie 's/#Port 22/Port 2222/g' /etc/ssh/sshd_config \
 && chmod 600 /etc/ssh/*_key \
 && chmod 644 /etc/ssh/*_key.pub \
 && mv /opt/factorio/config/config.ini /opt/factorio/config/config.ini.original \
 && ln -sf $CONFIG/config.ini /opt/factorio/config/config.ini \
 && cat /docker-entrypoint.sh | grep -v -E "^exec" > /docker-entrypoint-prepare.sh \
 && chmod +x /docker-entrypoint-prepare.sh

EXPOSE 2222

COPY factorio-*.sh /
RUN chmod +x /factorio-*.sh

ENTRYPOINT []
CMD ["/factorio-sshd-entrypoint.sh"]
