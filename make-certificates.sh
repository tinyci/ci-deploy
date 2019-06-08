#!/bin/bash

set -euo pipefail

mkdir -p ${HOME}/bin
curl -sSL https://github.com/FiloSottile/mkcert/releases/download/v1.3.0/mkcert-v1.3.0-$(uname -s | tr A-Z a-z)-amd64 >"${HOME}/bin/mkcert"
chmod 0755 ${HOME}/bin/mkcert

export CAROOT=roles/certificates/files/ca

mkdir -p $CAROOT
${HOME}/bin/mkcert -install -ecdsa

if [[ ! -f ${CAROOT}/tinyci-server.pem ]] || [[ ! -f ${CAROOT}/tinyci-server.key ]]
then
  ${HOME}/bin/mkcert -ecdsa -cert-file ${CAROOT}/tinyci-server.pem --key-file ${CAROOT}/tinyci-server.key $* localhost 127.0.0.1 ::1
fi

if [[ ! -f ${CAROOT}/tinyci-client.pem ]] || [[ ! -f ${CAROOT}/tinyci-client.key ]]
then
  ${HOME}/bin/mkcert -ecdsa -client -cert-file ${CAROOT}/tinyci-client.pem --key-file ${CAROOT}/tinyci-client.key $* localhost 127.0.0.1 ::1
fi
