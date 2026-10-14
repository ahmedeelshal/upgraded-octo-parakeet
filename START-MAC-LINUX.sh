#!/usr/bin/env sh
set -eu
cd "$(dirname "$0")"
node --version >/dev/null
node -e "if(Number(process.versions.node.split('.')[0])<22 || (Number(process.versions.node.split('.')[0])===22 && Number(process.versions.node.split('.')[1])<16)) process.exit(1)" || { echo "Node.js 22.16 or newer is required."; exit 1; }
if [ ! -f .env ]; then cp .env.example .env; fi
npm install
npm start
