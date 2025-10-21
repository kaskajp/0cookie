# Contributing

## Branching model
- main: stable releases
- develop: integration branch for next release
- feature branches: feature/<topic> -> merge to develop
- hotfix branches: hotfix/<topic> -> merge to main and develop

## Conventional Commits
Use Conventional Commits for semantic-release:
- feat: new feature
- fix: bug fix
- docs: documentation only changes
- chore: tooling, build, CI changes
- perf, refactor, test, style, build, ci, revert

Examples:
- feat(auth): add password reset
- fix(banner): preserve focus on open

## Pull Requests
- Target develop
- Include tests when reasonable
- Keep PRs focused and small

## Releases
- Semantic Release runs on pushes to main and develop
- develop creates prereleases; main creates stable releases

## Local dev
See server/README.md.
- Quick run: PORT=3000 bundle exec puma (in server/)
- With Docker Compose: docker-compose up --build
