# 0cookie

Self-hosted or SaaS cookie consent and scanning.

## Structure
- `PRD.md`: product requirements
- `server/`: Rails 8 app (Hotwire, Propshaft, SQLite dev)

## Quick start (dev)
```
cd server
bundle install
bundle exec rails db:prepare
ADMIN_EMAIL=admin@example.com ADMIN_PASSWORD=password123 bundle exec rails db:seed
PORT=3000 bundle exec puma
```
Visit http://localhost:3000 and sign in with the seeded admin.

See `server/README.md` for details.

## CI & Releases
- GitHub Actions CI runs on pushes/PRs to develop and main
- Semantic Release publishes prereleases from develop and stable releases from main

## Docker Compose
```
docker-compose up --build
```
Web at http://localhost:3000, MailHog UI at http://localhost:8025.
