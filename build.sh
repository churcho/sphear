#!/usr/bin/env bash
# exit on error
set -o errexit

# Compile assets
npm install --prefix apps/matx/assets
npm run deploy --prefix apps/matx/assets

# Compile assets
npm install --prefix apps/synaps/assets
npm run deploy --prefix apps/synaps/assets

mix phx.digest

# Initial setup
mix deps.get --only prod
mix clean
mix compile --force

# Build the release and overwrite
MIX_ENV=prod mix release --overwrite

# Run migrations
mix ecto.create
_build/prod/rel/sphear/bin/sphear eval "Db.Release.migrate"