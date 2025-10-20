# Product Requirements Document

## Project Name
0cookie

## Overview
0cookie is a self-hosted or managed SaaS service that helps website owners detect, categorize, block, and disclose cookies and other tracking technologies. It provides:
- A lightweight embed script that shows a compliant consent banner and enforces prior consent by default.
- Automatic scanning to discover cookies, storage, and network trackers, mapped into categories.
- A dashboard to review findings, manage categories/descriptions, and customize banner appearance.

## Goals and Objectives
- Provide a dashboard to manage cookies
- Provide a script that automatically finds, categorizes and blocks cookies on the website. The script will also show a cookie banner to the visitor of the website.
- Provide ways to customize the look and feel of the cookie banner.
- Provide ways to manually categorize cookies as well as changing their descriptions.

## Target Audience
- Website owners
- Web developers
- Companies with multiple websites

## Features
### SaaS and Self-hosted
- Modes: Self-hosted (single-tenant per install) and managed multi-tenant SaaS.
- Pricing: Both free initially; SaaS will introduce paid tiers later.
- Parity: Self-hosted has all features unlocked by default; SaaS uses plan entitlements.
- Data isolation (SaaS): Logical isolation by workspace; separate API keys; per-workspace rate limits.
- Domain verification (SaaS): Require DNS TXT or HTML meta-tag verification before scanning/embedding to prevent abuse.

### Plans & Entitlements (SaaS)
- Plan examples: Free, Pro, Business (placeholders; pricing TBD).
- Entitlements: Feature flags and limits per plan (e.g., `websites_limit`, `scan_pages_monthly`, `webhook_access`, `audit_retention_days`, `support_sla`).
- Enforcement: Backend checks on protected actions (create website, start scan, enable webhooks).
- Upgrade UX: In-app plan page, usage meter, upgrade CTAs on limit exceed.
- Billing timing: Not activated initially; plans operate in free mode with limits soft-enforced or disabled.
### Compliance & Consent
- Consent framework: GDPR/UK GDPR, ePrivacy, ePrivacy Sweden, and CPRA/CPRA Do Not Sell/Share.
- Consent model: Prior consent (block non-essential until consent), granular purpose-level choices.
- Proof of consent: Store consent logs (timestamp, purposes, policy version, geo, user agent, IP hash).
- Consent lifespan: Default 6 months; configurable per workspace.
- Withdrawal: Easy change via banner re-open button and programmatic API.
- Geo-behavior: Geo-detect region to select banner variant and default language; EU/UK show full banner, outside EU default to simple notice with opt-out if configured. Allow per-website static behavior override.
- Do Not Track/Global Privacy Control: Respect GPC automatically where applicable.
- Multilingual: i18n-ready using BCP 47 language tags; default en-US. Workspace can set default language. Allow per-embed language override via script parameter or data attribute.
- Re-consent: Trigger re-consent when policy version changes, categories change, or new purposes are introduced.
- Consent logs retention: Keep 24 months by default; configurable up to unlimited retention.
- IP hashing: SHA-256 with rotating pepper stored server-side; rotate on a schedule.

### Accounts & User Authentication
- A workspace must have at least one admin
- Users must be able to log in securely with passwords following the latest NIST recommendations.
- Register, Login, Logout, Password Reset
- Token-based session (JWT or equivalent)
- 2FA (Two-Factor Authentication), email or app-based (TOTP)
- Each account is associated with a "workspace"
- Each workspace can have multiple users
- Users can either be "admin" or "user"
 - Email delivery: SMTP configuration for transactional emails (password reset, 2FA one-time codes)

### Cookie banner
- Automatically find, categorize and block cookies; essential cookies are always allowed.
- Primary actions: "Accept all", "Reject all", "Save preferences" (for selected).
- Category toggles: Essential (locked on), Functional, Analytics, Personalization, Marketing.
- Details panel: Expandable list of cookies per category with description, domain, expiry.
- Policy links: Cookie Policy and Privacy Policy URLs configurable per workspace.
- Accessibility: WCAG 2.1 AA, focus trapping, ARIA roles, keyboard-only operation.
- Performance: Banner payload under 10KB gzipped, minimal layout shift, no external fonts.
- Branding: "Powered by 0cookie" link enabled by default; can be turned off in cookie banner settings.
- Cross-subdomain consent: Disabled by default; do not share consent across subdomains.

### Embed script & auto-blocking
- Install: Single `<script src>` tag with workspace public key; no build tools required.
- Auto-blocking mode: Default block of scripts/storage until consent for their category is given.
- Data attributes: `data-0cookie-category` on scripts/iframes to declare purposes.
- Pattern rules: Library of known vendor patterns (domains, paths) mapped to categories.
- Prior consent enforcement: Intercept `document.write`, `appendChild`, and `createElement` for trackers.
- API: `window._0cookie` with `open()`, `getConsent()`, `setConsent()`, `onChange(handler)`.
- Consent storage: First-party cookie and localStorage with integrity signature; server logs copy.
- CSP compatibility: Provide nonce support and attribute-based allowlisting.
- Language override: `?lang=en-US` (example) or `data-0cookie-lang="en-US"`; supports any BCP 47 tag.
- Hosting: Serve embed script from dedicated subdomain (e.g., `cdn.0cookie.app`) for SaaS; self-hosted serves from its own origin.

### Scanning
- Types: Client-side script scan (DOM, cookies, storage, network), and server-side crawler.
- Frequency: Manual on-demand and scheduled (e.g., daily/weekly) per website.
- Output: Discovered cookies, localStorage, sessionStorage, IndexedDB presence, and third-party requests.
- Classification: Match against known database; heuristic fallback (name, domain, path, expiry) to suggest category.
- Reports: Delta since last scan, new/changed/removed items, confidence scores.
- Safety: Respect robots.txt; rate limits; user-agent identifying 0cookie crawler.
- Engine: Headless browser rendering enabled for JS-heavy sites; HTML-only fallback mode available.
- Scope: Cap to 5,000 pages per scan by default; easily configurable per workspace/website.
- Quotas (SaaS): Enforce monthly limits like scanned subpages and max concurrency per plan; show remaining quota in dashboard.
- Counting rule: A scanned subpage counts as a unique canonical URL after redirects; ignore query strings unless path changes.

## Cookie management dashboard
- Add, edit and delete websites to be monitored.
- Set scanning interval for the website.
- Manually scan the website for cookies.
- View the list of cookies found on the website.
- View the details of a cookie.
- Set the category of a cookie.
- Export the list of cookies to a CSV file.

### Dashboard & RBAC
- Workspaces: Multiple websites per workspace; roles: admin, member (read/write), viewer (read-only).
- Audit log: Track changes to categories, texts, and settings with actor and timestamp.
- Banner theming: Live preview; presets for light/dark; custom CSS variables.
- Cookie registry: Global shared dictionary of known cookies/vendors; workspace can override descriptions and category.
- Environments: Production / staging configuration per website.
- Webhooks: Notify on scan completion and consent changes (optional).
- Usage & plans (SaaS): Usage page with meters (scan pages used/remaining, websites count), current plan, and upgrade path.

### Data model (high-level)
- Workspace(id, name, settings)
- User(id, email, password_digest, mfa_enabled)
- Membership(user_id, workspace_id, role)
- Website(id, workspace_id, url, scan_schedule, status)
- Scan(id, website_id, started_at, finished_at, results_summary)
- CookieFinding(id, scan_id, name, domain, path, expiry, category_suggested, confidence)
- ConsentRecord(id, website_id, session_id_hash, purposes, region, policy_version, created_at)
- BannerTheme(id, workspace_id, variables)
- Plan(id, name, entitlements)
- Subscription(id, workspace_id, plan_id, status, period_start, period_end)
- UsageMeter(id, workspace_id, metric, period_start, period_end, used)

## Cookie banner settings
- Logo for the cookie banner.
- Background color for the cookie banner.
- Text color for the cookie banner.
- Button text color for the cookie banner.
- Button background color for the cookie banner.
- Button border color for the cookie banner.
- Button border radius for the cookie banner.
- Font size for the cookie banner.
- Font family for the cookie banner.
- Font weight for the cookie banner.
- Font color for the cookie banner.

## Other features
- Keep a database of known cookies and their descriptions, seeded from a community source where available (e.g., reputable lists), and curated thereafter. Used to automatically find, categorize and block cookies on the website. This database is updated and shared by all workspaces.

## Tech Stack
- Backend: Ruby on Rails 8
- Frontend: Hotwire (Turbo, Stimulus)
- Assets: Propshaft, CSS-only theming
- Database: SQLite (self-hosted default), Postgres for SaaS
- Hosting: Local machine, Raspberry Pi, or VPS
- CI/CD: GitHub Actions with Semantic Release (https://github.com/semantic-release/semantic-release)
- No Node, no JS build tools, no build for CSS

## Deployment
- Modes: Docker Compose and bare metal instructions for Ubuntu/Debian and macOS.
- Secrets: Rails credentials for keys; workspace public key for embed script.
- HTTPS: Caddy or Nginx reverse proxy with Let's Encrypt.
- Backups: SQLite backups daily with retention policy; export/import commands documented.
- Observability: Rails logs, health endpoint `/healthz`, basic metrics endpoint.
- SaaS: Multi-tenant DB schema, per-tenant rate limits, background workers for scans (e.g., Sidekiq/Rails jobs), and usage metering cron.

## Performance & Reliability
- Cold start: < 500ms banner render on typical hardware.
- Script size: < 10KB gzipped; zero third-party dependencies.
- Server: P95 API latency < 150ms on Raspberry Pi 4.
- Resilience: Graceful degradation if server unreachable—banner still renders and uses last consent.
- Rate limits: Protect scanning and admin APIs.

## Success Metrics
- Can be installed and used locally without external services.
- Loads in under 1s on typical home hardware.
- Ease of use with great documentation.
- Stable across major mobile/tablet browsers.

## Design
- Take inspiration from Linear's design (https://linear.app/homepage)
- Use Space Grotesk font family for headings and Inter for body text
- Light and dark mode
- Custom SVG icons for buttons and other UI elements (Nucleo Icons)
 - Initial languages: English (en-US), Swedish (sv-SE), Norwegian Bokmål (nb-NO), Finnish (fi-FI), German (de-DE)

## Documentation
- README.md - project overview, installation and usage instructions
- PRD.md (this file) - detailed project requirements, keep this updated with the latest requirements.
- AGENTS.md - documentation for AI agents
- CONTRIBUTING.md - contributing guidelines with info about Semantic Release
- LICENSE.md - license information
- API documentation (Swagger)
- Deployment instructions (Docker or bare metal)
- CODE_OF_CONDUCT.md - code of conduct

## Assumptions
- Self-hosted, single-tenant per installation; multi-workspace support within one install.
- No external CDNs or tracking; privacy by design.
- Customers provide their own policies and legal texts; templates optional.

## Non-goals (v1)
- Full CMP TCF 2.2 integration.
- Server-side tag management.
- Historical analytics of consent rates beyond basic aggregates.

## Open questions
- None at this time.