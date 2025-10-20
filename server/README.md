# 0cookie server

## Prerequisites
- Ruby 3.4.4
- Bundler 2.6+

## Setup
```
bundle install
bundle exec rails db:prepare
ADMIN_EMAIL=admin@example.com ADMIN_PASSWORD=password123 bundle exec rails db:seed
```

## Run (dev)
```
PORT=3000 bundle exec puma
```

Jobs run inline in development. To use Solid Queue later, remove the inline adapter in `config/environments/development.rb` and enable the plugin in `config/puma.rb`.

## SMTP (dev defaults)
Set `SMTP_ADDRESS`, `SMTP_PORT`, `SMTP_USERNAME`, `SMTP_PASSWORD`, `SMTP_FROM` as needed. Defaults use localhost:1025.

## Notes
- SQLite databases live under `storage/`
- Secrets: use `rails credentials:edit` for production; `config/master.key` is ignored by git.
