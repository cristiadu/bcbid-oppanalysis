#!/usr/bin/env bash

echo "======== BCBID OPPORTUNITY CSV PARSER: Running Parser =========="
export PATH="$PATH:${HOME}/.local/bin" && echo "=> Configured PATH variable on current Terminal session"
robot robot/parse-bcbid-opportunities.robot && echo "=> Executed the Robot Framework Scenarios."
echo "================================================================"
echo "====== BCBID OPPORTUNITY CSV PARSER: Execution Completed! ======"