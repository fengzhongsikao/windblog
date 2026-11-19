#!/usr/bin/env bash
set -euo pipefail

# themes/paper is a git submodule. Vercel does not check out its files,
# so clone the theme when this build does not already have it.
if [[ ! -f themes/paper/theme.toml ]]; then
  echo "themes/paper is missing, cloning hugo-paper"
  rm -rf themes/paper
  git clone --depth 1 https://github.com/nanxiaobei/hugo-paper.git themes/paper
fi

if [[ "${VERCEL_ENV:-}" == "production" && -n "${VERCEL_PROJECT_PRODUCTION_URL:-}" ]]; then
  BASE_URL="https://${VERCEL_PROJECT_PRODUCTION_URL}/"
else
  BASE_URL="https://${VERCEL_URL}/"
fi

hugo --gc --minify --baseURL "${BASE_URL}"
