---
haproxy:
  pkg.installed

haproxy configuration:
  file.managed:
    - name: /etc/haproxy/haproxy.cfg
    - source: salt://states/haproxy/files/haproxy.cfg
    - user: root
    - group: root
    - mode: '0644'

haproxy service management:
  service.running:
    - name: haproxy
    - enable: True
