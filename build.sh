#!/usr/bin/env bash
# exit on error
set -o errexit

# Initial setup
mix deps.get --only prod
MIX_ENV=prod mix compile

NODE_ENV=production
# Compile assets
npm install --prefix apps/matx/assets
npm run deploy --prefix apps/matx/assets

# Compile assets
npm install --prefix apps/synaps/assets
npm run deploy --prefix apps/synaps/assets

mix phx.digest

# Remove the existing release directory and build the release
rm -rf "_build"
MIX_ENV=prod mix release

# Run migrations
_build/prod/rel/sphear/bin/sphear eval "Db.Release.migrate"