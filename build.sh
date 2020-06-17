#!/usr/bin/env bash
# exit on error
set -o errexit

# Initial setup
mix deps.get --only prod
MIX_ENV=prod mix compile

# Compile assets
npm install --prefix ./apps/matx/assets
npm run deploy --prefix ./apps/matx/assets

npm install --prefix ./apps/blippx/assets
npm run deploy --prefix ./apps/blippx/assets

mix phx.digest

# Remove the existing release directory and build the release
rm -rf "_build"
MIX_ENV=prod mix release

# Run migrations
_build/prod/rel/sphear/bin/sphear eval "Db.Release.migrate"