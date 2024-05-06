default_recipe:
  just --list

print_env:
  # Print environment variables
  set dotenv-filename := "project_config.txt"
  echo $PROJECT_ID

ts_create_tsc_config:
  cd backend && tsc --init --sourceMap --rootDir src --outDir dist

npm_create_config:
  cd backend && npm init -y

git_enforce_story_id:
  cp githooks/commit-msg .git/hooks/
  chmod +x .git/hooks/commit-msg

git_push_new_branch BRANCH:
  git push -u origin {{BRANCH}}

backend_pretty_logs:
  cd backend/dist && node index.js | npx pino-pretty

backend_debug_app:
  cd backend/dist && DEBUG=APP node index.js | npx pino-pretty

backend_develop_app:
  cd backend && npm run dev

backend_develop_pretty:
  cd backend && npm run dev | npx pino-pretty

gcp_deploy_backend_GAE:
  cd backend && gcloud app deploy

gcp_browse_deployed_app:
  cd backend && gcloud app browse

gcp_delete_default_VPC:
  ./backend/scripts/delete_default_VPC.sh

gcp_save_config:
  ./backend/scripts/save_gcloud_config.sh
gcp_download_SA_key SA:
  echo $PROJECT_ID
  gcloud iam service-accounts keys create {{SA}}.json --iam-account={{SA}}@$PROJECT_ID.iam.gserviceaccount.com

gcp_login_with_SAKey SA:
  cd terraform-config/scripts && ./gcp_login_SA_Key.sh {{SA}}
  
  
