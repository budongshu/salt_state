{% for pkg in ['php','','' ]%} 
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

