install_dep_pkg: 
  pkg.installed:
    - names: 
      - curl 
      - libcurl-devel 
      - libjpeg-devel
      - libpng-devel
      - libjped-devel
      - freetype-devel 
      - libxslt-devel  
      - boost-devel
      - gperf
      - libevent-devel 
      - libuuid-devel
      - libgearman 
      - libgearman-devel
      

{% for pkg in ['php7-7.0.28-1.el6.x86_64.rpm','php7-libmemcached-1.0.18-1.el6.x86_64.rpm','php7-rabbitmq-c-0.8.0-1.el6.x86_64.rpm' ]%} 
copy_install_rpm_{{ pkg }}: 
  file.manager: 
    - name: /opt/{{ pkg }}
    - source: salt://php/files/rpm/{{ pkg }}
  cmd.run: 
    - name: rpm -ivh {{ pkg  }} 
    - unless: test -d /Data/apps/php 
{% endfor %} 
copy_php_ini:
  file.manager: 
    - name: /Data/apps/php/lib/php.ini
    - source: salt://php/files/php.ini 
    - mode: 0755
copy_php_fpm_config: 
  file.manager: 
    - name: /Data/apps/php/etc/php-fpm.conf 
    - source: salt://php/files/php-fpm.conf 
copy_php_init: 
  file.manager: 
    - name: /etc/init.d/php-fpm  
    - source: salt://php/files/php-fpm 
    - mode: 0755
