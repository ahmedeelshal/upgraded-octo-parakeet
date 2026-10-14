'use strict';
self.addEventListener('install', event => { self.skipWaiting(); });
self.addEventListener('activate', event => { event.waitUntil(self.clients.claim()); });
self.addEventListener('push', event => {
  let data = {};
  try { data = event.data ? event.data.json() : {}; } catch (_) { data = { body: event.data ? event.data.text() : '' }; }
  event.waitUntil(self.registration.showNotification(data.title || 'MAAK | معك', {
    body: data.body || 'You have a reminder.',
    icon: '/assets/maak-logo.svg',
    badge: '/assets/maak-logo.svg',
    tag: data.tag || 'maak-reminder',
    data: { url: data.url || '/' }
  }));
});
self.addEventListener('notificationclick', event => {
  event.notification.close();
  const target = event.notification.data && event.notification.data.url || '/';
  event.waitUntil(self.clients.matchAll({ type:'window', includeUncontrolled:true }).then(clients => {
    for (const client of clients) if ('focus' in client) { client.navigate(target); return client.focus(); }
    return self.clients.openWindow ? self.clients.openWindow(target) : undefined;
  }));
});
