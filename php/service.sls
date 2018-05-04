include: 
  - php.install
service_php_start: 
  service.running: 
    - name: php-fpm 
    - enable: True
    - reload: True
    - watch:
      - file: /Data/apps/php/etc/php-fpm.conf
      - file: /Data/apps/php/lib/php.ini 

