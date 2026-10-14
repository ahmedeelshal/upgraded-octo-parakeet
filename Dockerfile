# MAAK deployable container — Node.js 22 LTS with built-in SQLite API
FROM node:22.16-bookworm-slim
ENV NODE_ENV=production HOST=0.0.0.0 PORT=4173 MAAK_DB_PATH=/var/lib/maak/maak.sqlite MAAK_BACKUP_DIR=/var/lib/maak/backups
WORKDIR /app
COPY --chown=node:node package.json ./
RUN npm install --omit=dev --no-audit --no-fund
COPY --chown=node:node . .
RUN mkdir -p /var/lib/maak/backups && chown -R node:node /app /var/lib/maak && chmod 700 /var/lib/maak
USER node
EXPOSE 4173
HEALTHCHECK --interval=30s --timeout=5s --start-period=15s --retries=3 CMD node -e "fetch('http://127.0.0.1:4173/api/health').then(r=>process.exit(r.ok?0:1)).catch(()=>process.exit(1))"
CMD ["node", "server.js"]
