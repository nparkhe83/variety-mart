create_tsc_config:
  cd backend && tsc --init --sourceMap --rootDir src --outDir dist

create_npm_config:
  cd backend && npm init -y

enforce_story_id:
  cp githooks/commit-msg .git/hooks/
  chmod +x .git/hooks/commit-msg

push_new_branch BRANCH:
  git push -u origin {{BRANCH}}

pretty_logs:
  cd backend/dist && node index.js | npx pino-pretty

develop_backend:
  cd backend && npm run dev

develop_backend-pretty:
  cd backend && npm run dev | npx pino-pretty