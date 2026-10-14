# MAAK v2 — engineering status and production gates

## Delivered in this iteration
- Account registration and login endpoints with scrypt password hashes.
- Random server sessions, SHA-256 token hashes in SQLite, HttpOnly/SameSite cookies, logout, and session expiry cleanup.
- Per-user state and push-subscription storage with foreign-key ownership isolation.
- SQLite WAL persistence, schema validation, request-size limits, same-origin mutation checks, rate limits, response security headers, static file denylist, and fail-closed remote binding.
- Server-side AI gateway with per-user request limiting and upstream timeout.
- Optional Web Push reminder worker and browser notification UI.
- User JSON export/import endpoints and UI JSON import/export.
- SQLite backup utility with retention rotation.
- Integration test proving unauthenticated access is denied and two accounts cannot read each other's state.

## Known gaps — do not call this a finished public SaaS
1. Email verification, password reset, MFA/passkeys, account deletion, and session-management UI are not implemented.
2. SQLite database files are not encrypted at rest. Use encrypted host volumes and encrypted backups if needed; consider managed PostgreSQL for a multi-instance deployment.
3. CSRF defense currently relies on same-origin validation for mutation requests and SameSite cookies. Review and strengthen this for the exact reverse-proxy/browser deployment.
4. AI is not configured until the operator provides a valid provider key and model. There are no native tool actions, and AI does not automatically edit user records.
5. Push delivery is best-effort, not a durable queue with retries, receipts, quiet hours, per-time-zone scheduling, or delivery analytics.
6. No active OAuth integrations for calendar, email, bank feeds, cloud storage, or health systems.
7. No independent penetration test, load test, formal accessibility audit, deployment CI/CD, monitoring/alerting, or incident-response runbook.
8. Legal/privacy documents, consent flows, billing, support, and service-level objectives remain to be designed for the intended markets.

## Before public production
- [ ] Deploy behind HTTPS with secure cookies and managed secrets.
- [ ] Verify backup restoration and off-site retention.
- [ ] Add email verification, password reset, MFA/passkeys, account deletion, and privacy controls.
- [ ] Complete threat modeling and independent security review; remediate critical/high findings.
- [ ] Add structured logs, monitoring, alerts, dependency scanning, CI/CD, and disaster-recovery drills.
- [ ] Add automated UI/e2e, accessibility, load, and cross-browser tests.
- [ ] Review data minimization, AI-provider disclosure/consent, retention, and applicable legal requirements.
- [ ] Implement external integrations only through official APIs/OAuth and least-privilege permissions.

**Release classification:** self-hosted beta foundation. Do not market as a fully completed or audited global SaaS.
