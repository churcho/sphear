#!/usr/bin/env bash
# exit on error
set -o errexit

# Initial setup
mix deps.get --only prod
MIX_ENV=prod mix compile

# Compile assets
npm install --prefix ./apps/mithral_web/assets
npm run deploy --prefix ./apps/mithral_web/assets

npm install --prefix ./apps/tavus/assets
npm run deploy --prefix ./apps/tavus/assets

mix phx.digest

# Remove the existing release directory and build the release
rm -rf "_build"
MIX_ENV=prod mix release

# Run migrations
_build/prod/rel/mithral/bin/mithral eval "Mithral.Release.migrate"