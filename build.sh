#!/usr/bin/env bash
set -euo pipefail

if [[ "${VERCEL_ENV:-}" == "production" && -n "${VERCEL_PROJECT_PRODUCTION_URL:-}" ]]; then
  BASE_URL="https://${VERCEL_PROJECT_PRODUCTION_URL}/"
else
  BASE_URL="https://${VERCEL_URL}/"
fi

hugo --gc --minify --baseURL "${BASE_URL}"
