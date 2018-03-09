---
httpd:
  pkg.installed

Add website files:
  file.managed:
    - name: /var/www/html/index.htm
    - source: salt://states/webserver/files/index.htm
    - user: apache 
    - group: apache
    - mode: "0644" 
    - template: jinja

httpd service management:
  service.running:
    - name: httpd
    - enable: true
