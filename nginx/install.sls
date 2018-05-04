{% set nginx_user = 'avatar' %}
{% set nginx_group = 'avatar' %}
{% for pkg in ['luajit-2.0.4-2.el6.x86_64.rpm','tengine-2.1.2-2.el6.x86_64.rpm']  %}
copy_rpm_{{ pkg }}: 
  file.manager: 
    - name: /opt/{{ pkg }}
    - source: salt://nginx/files/rpm/{{ pkg }} 
    - mode: 0644
{% endfor %}
install_tengine: 
  cmd.run: 
    - name: rpm -ivh  luajit-2.0.4-2.el6.x86_64.rpm  && rpm -ivh  tengine-2.1.2-2.el6.x86_64.rpm
    - unless: test -d /Data/apps/nginx
copy_nginx_config:
  file.manager: 
    - name: /Data/apps/nginx/conf/nginx.conf  
    - source: salt://nginx/files/nginx.conf  
    - require: 
      - cmd: install_tengine
copy_nginx_init:
  file.manager: 
    - name: /etc/init.d/nginx   
    - source: salt://nginx/files/nginx  
    - require: 
      - cmd: install_tengine
rsync_nginx_vhosts:
  file.recurse:
    - name: /Data/apps/nginx/conf/vhosts
    - source: salt://nginx/files/vhosts
    - user: {{ nginx_user  }}
    - group: {{ nginx_group }}
    - require: 
      - cmd: install_tengine
chmod_nginx_directory: 
 file.directory:
    - name: /Data/apps/nginx/logs
    - user: avatar
    - group: avatar
    - makedirs: True
    - mode: 0755
