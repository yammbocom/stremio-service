// Adds *.yammbo.com to the Stremio server.js CORS origin whitelist so the
// Yammbo TV web client (served over HTTPS from tv.yammbo.com) can talk to the
// local streaming server. Without this the browser blocks the request (the
// upstream server.js only allows *.strem.io / *.stremio.com / *.stremio.net).
//
// Usage: node patch-server-cors.js [path-to-server.js]
//        (defaults to resources/bin/windows/server.js for the CI build)
const fs = require('fs');
const p = process.argv[2] || 'resources/bin/windows/server.js';
let s = fs.readFileSync(p, 'utf8');
const find = 'req.headers.origin.match(".stremio.com(:80)?$")';
const inject = find + ' || req.headers.origin.match(".yammbo.com(:80)?$")';
if (s.indexOf('.yammbo.com(:80)?$') !== -1) {
  console.log('server.js already patched for yammbo.com');
  process.exit(0);
}
if (s.indexOf(find) === -1) {
  console.error('ERROR: CORS whitelist pattern not found in ' + p);
  process.exit(1);
}
s = s.replace(find, inject);
fs.writeFileSync(p, s);
console.log('server.js CORS whitelist patched: +.yammbo.com');
