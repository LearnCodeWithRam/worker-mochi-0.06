#!/usr/bin/env bash

# Use libtcmalloc for better memory management
TCMALLOC="$(ldconfig -p | grep -Po "libtcmalloc.so.\d" | head -n 1)"
export LD_PRELOAD="${TCMALLOC}"

# Set PYTHONPATH so ComfyUI's own packages (utils/, app/, etc.) take precedence.
# /ComfyUI must come BEFORE /ComfyUI/src to avoid flat utils.py shadowing
# the utils/ package that ComfyUI's server.py expects.
export PYTHONPATH="/ComfyUI:/ComfyUI/src:${PYTHONPATH}"

# Run handler as a plain script from the /ComfyUI working directory so that
# relative imports inside ComfyUI resolve correctly.
cd /ComfyUI

if [ "$SERVE_API_LOCALLY" == "true" ]; then
    python3 -u /ComfyUI/src/handler.py --rp_serve_api --rp_api_host=0.0.0.0
else
    python3 -u /ComfyUI/src/handler.py
fi