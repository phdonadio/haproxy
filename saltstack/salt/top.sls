---
base:
  '*':
      - states.common
  'web*':
    - states.webserver
  'haproxy*':
    - states.haproxy
