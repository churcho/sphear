#!/usr/bin/env bash
# exit on error
set -o errexit

# Initial setup
mix deps.get --only prod
mix clean
mix compile --force

mix phx.digest

# Compile assets
npm install --prefix apps/matx/assets
npm run deploy --prefix apps/matx/assets

# Compile assets
npm install --prefix apps/synaps/assets
npm run deploy --prefix apps/synaps/assets

# Build the release and overwrite
MIX_ENV=prod mix release --overwrite

# (Create db and) run migrations
_build/prod/rel/sphear/bin/sphear eval "Db.Release.create_and_migrate"