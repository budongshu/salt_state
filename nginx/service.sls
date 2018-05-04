include: 
  - nginx.install

service_nginx_start:
  service.running:
    - name: nginx
    - enable: True
    - reload: True
    - require:
      cmd: install_tengine
      file: /etc/init.d/nginx
    - watch:
      file: /Data/apps/nginx/conf/vhosts
      file: /Data/apps/nginx/conf/nginx.conf

nginx_cut_log:
  file.managed:
    - name: /Data/shell/nginx/del_log.sh
    - source: salt://nginx/files/del_log.sh
  cron.present:
   - name:  /bin/bash /Data/shell/nginx/del_log.sh
   - user: root
   - minute: 33
   - hour: 1
   - require:
     - file: nginx_cut_log
