# MAAK | معك — v2 account-based foundation

MAAK is an Arabic-first personal life-management web app with an original blue identity, RTL/LTR interface, account access, per-user data isolation, SQLite persistence, JSON import/export, a server-side AI gateway, and optional Web Push reminders.

## Release status — read before deploying

This release is a stronger **self-hosted beta foundation**, not a certified or fully managed global SaaS. It now has registration/login, per-user state isolation, hashed session tokens, password hashing with scrypt, SQLite storage, basic request limits, same-origin checks for mutating API calls, security headers, an AI gateway, and automated integration tests. It still needs independent security review, HTTPS hosting, operational monitoring, tested restore procedures, and product-specific legal/privacy review before public production use.

No third-party AI key, domain, cloud account, or paid integration is included. Online AI works only after you add your own provider key. Background push requires HTTPS, `web-push`, VAPID keys, browser permission, and a running server.

## Features in this build

- Account creation and login using email and a password of at least 12 characters.
- Passwords hashed with Node.js `scrypt`; random session tokens stored as SHA-256 hashes; HttpOnly, SameSite=Lax session cookies.
- Per-account app state stored in SQLite, rather than a shared JSON state file.
- Personal dashboard and modules: tasks/reminders, health notes, career/CV records, learning, finance, projects, documents, relationships, and planning.
- Arabic RTL and English LTR, responsive interface, search, JSON export/import, and profile name syncing.
- Server-side OpenAI-compatible AI gateway with a request timeout and per-account rate limiting; API keys never go to browser code.
- Browser notifications while the app is open and optional Web Push for background reminders.
- SQLite online backup script with retention rotation.
- Security headers, static-path restrictions, input-size/schema validation, and integration tests for auth and account isolation.

## Requirements

- Node.js **22.13+** (Node 22.16+ is recommended because this project uses the built-in `node:sqlite` API).
- npm and a modern browser.

## Run locally

1. Extract the ZIP and open a terminal in the `maak-platform` directory.
2. Run `npm install`.
3. Copy `.env.example` to `.env` (on Windows, `copy .env.example .env`; on macOS/Linux, `cp .env.example .env`).
4. Run `npm test` to execute the integration test suite.
5. Run `npm start`.
6. Open `http://127.0.0.1:4173` and create your account.

Windows users can run `START-WINDOWS.bat`; macOS/Linux users can run `START-MAC-LINUX.sh`.

## Connect a real AI provider

1. Obtain an API key from the AI provider you choose.
2. Add it to `.env` as `OPENAI_API_KEY=...`.
3. Set `AI_BASE_URL` and `AI_MODEL` to a model available to your account.
4. Restart the server.

The server expects an OpenAI-compatible `/chat/completions` endpoint. Provider usage can cost money. Never add the key to `index.html`, send it in chat, or commit `.env`. Only the user's message and selected context sent by the client are forwarded to the configured AI provider; review the provider's data terms before sending sensitive details.

## Enable background notifications

1. Run `npm install` so the optional `web-push` dependency is installed.
2. Generate keys using `npx web-push generate-vapid-keys`.
3. Add `VAPID_PUBLIC_KEY`, `VAPID_PRIVATE_KEY`, and a valid `VAPID_SUBJECT` to `.env`.
4. Use HTTPS (localhost is suitable for local development), restart the server, and choose **Notifications → Enable device notifications**.

The server must be running when reminders become due. Browser/OS battery settings and notification permissions can affect delivery. Without VAPID and HTTPS, only in-app/browser-open notifications are available.

## Database and backups

- Main database: `data/maak.sqlite` (SQLite WAL mode; private local file).
- User-level JSON export/import is available from the app interface.
- Create a consistent SQLite backup while the server is running with `npm run backup`.
- By default, backups are stored under `data/backups/`; the latest 14 are retained. Keep this directory private and copy backups off-device. Backups may contain sensitive personal data.
- Test restoration periodically on a separate copy. Do not treat backup creation alone as a disaster-recovery plan.
- To import a legacy MAAK JSON backup, sign in and use the app's import option. Review the resulting records before continuing.

## Remote hosting — not a one-click public SaaS

The server binds to `127.0.0.1` by default. It refuses remote binding unless `MAAK_TRUST_PROXY=true` is set. Only set that flag when the service is behind a trusted HTTPS reverse proxy that terminates TLS and correctly sets `X-Forwarded-Proto`. Do not expose Node directly to the public internet.

Before public launch, additionally implement and verify: email verification and password reset, MFA/passkeys, CSRF protection suitable for the chosen deployment, account deletion and data-retention controls, encrypted backups and secrets management, structured logs/metrics/alerts, dependency and container scanning, a tested deployment pipeline, independent penetration testing, load/accessibility tests, and a privacy policy. External email, calendar, banking, cloud file storage, and medical-system integrations are not active; each needs official APIs/OAuth, explicit consent, and least-privilege scopes.

## Privacy and safety

- Do not store passwords, API keys, or secrets as notes.
- Avoid entering highly sensitive medical, financial, or identity data until the deployment has received a suitable security/privacy review.
- AI responses are informational and do not execute actions, diagnose illness, transfer money, or send messages.
- This project is not a certified medical-record system, banking application, or regulated data platform.


## Deployment bundle (v2.1)
See `DEPLOY-NEXT-STEPS-AR.md`, `render.yaml`, `Dockerfile`, and `docker-compose.yml` for deployment scaffolding. The cloud service is not created automatically: a hosting account, repository authorization, and real secrets are required.
