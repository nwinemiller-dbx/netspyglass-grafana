#!/usr/bin/env bash
#
# Grafana startup script

HAPPYGEARS_DIR="/happygears"

GRAFANA_HOME_DIR="/opt/grafana"
GRAFANA_PLUGINS_DIR="$GRAFANA_HOME_DIR/plugins/"
GRAFANA_PROVISIONING_DIR="$GRAFANA_HOME_DIR/provisioning"

#INIT_DIR=${GRAFANA_HOME_DIR}/.initialized
#
#mkdir ${INIT_DIR} 2>/dev/null || {
#    echo "${INIT_DIR} exists. Assuming volume ${GRAFANA_HOME_DIR} has already been initialized"
#    /run.sh
#    exit 0
#}

cd ${HAPPYGEARS_DIR}

set -x
set -e

PLUGIN_ID=$(jq -r '.["id"]' dist/plugin.json) && \
    mkdir -p ${GRAFANA_PLUGINS_DIR}/${PLUGIN_ID} && \
    cp -r dist/* ${GRAFANA_PLUGINS_DIR}/${PLUGIN_ID}/

mkdir -p ${GRAFANA_PROVISIONING_DIR}
chown grafana.grafana ${GRAFANA_PROVISIONING_DIR}

cp -r ${HAPPYGEARS_DIR}/grafana/provisioning/*  ${GRAFANA_PROVISIONING_DIR}/

ls -laR ${GRAFANA_PROVISIONING_DIR}/

/run.sh
