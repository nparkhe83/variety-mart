create_tsc_config:
  cd backend && tsc --init --sourceMap --rootDir src --outDir dist

create_npm_config:
  cd backend && npm init -y

enforce_story_id:
  cp githooks/commit-msg .git/hooks/
  chmod +x .git/hooks/commit-msg
