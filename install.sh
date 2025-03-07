#!/usr/bin/env bash

set -euf -o pipefail
DEFAULT_VERSION="0.6.0+qlever"
if [[ $(helm version --short | head -c2) == "v2" ]]; then
	echo "This plugin version support only Helm 3. Defaulting to previous version"
	DEFAULT_VERSION="0.3.0"
fi
HELM_EDIT_VERSION=${HELM_EDIT_VERSION:-"${DEFAULT_VERSION}"}

file="${HELM_PLUGIN_DIR:-"$(helm home)/plugins/helm-edit"}/helm-edit"
os=$(uname -s | tr '[:upper:]' '[:lower:]')
# FIXME: automatically use releases from current repo?
#url="https://github.com/mstrzele/helm-edit/releases/download/v${HELM_EDIT_VERSION}/helm-edit_${os}_amd64"
url="https://github.com/qlever-llc/helm-edit/releases/download/v${HELM_EDIT_VERSION}/helm-edit_${os}_amd64"

if command -v go; then
	go build
	#cp helm-edit "${file}"
elif command -v wget; then
	wget -O "${file}" "${url}"
elif command -v curl; then
	curl -o "${file}" -L "${url}"
fi

chmod +x "${file}"
