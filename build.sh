#!/usr/bin/env bash
set -euo pipefail

# themes/paper is a git submodule. Vercel does not check out its files,
# so clone the theme when this build does not already have it.
if [[ ! -f themes/paper/theme.toml ]]; then
  echo "themes/paper is missing, cloning hugo-paper"
  rm -rf themes/paper
  git clone --depth 1 https://github.com/nanxiaobei/hugo-paper.git themes/paper
fi

# Article cards use absolute Permalinks. Do not bake in VERCEL_URL:
# that hostname is the single deployment, and with Standard Deployment
# Protection Vercel answers it with 404 DEPLOYMENT_NOT_FOUND. A relative
# baseURL keeps links on the host the visitor already opened.
hugo --gc --minify --baseURL /
