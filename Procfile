release: POSTGRES_STATEMENT_TIMEOUT=600s bundle exec rails db:chatwoot_prepare && echo $SOURCE_VERSION > .git_sha
web: bundle exec puma -C config/puma.rb
worker: bundle exec rails ip_lookup:setup && bundle exec sidekiq -C config/sidekiq.yml
