#!/usr/bin/env bash
set -euo pipefail
base=$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)
exec "$base/hooks/toolbox.sh" pmd-cli "$@"
