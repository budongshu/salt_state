install_mysql:
  pkg.install: 
    - name: mysql-server mysql
    - unless: test -d /usr/local/mysql 

copy_mysql_conf:
  file.manager:  
    - name: /etc/my.conf 
    - source: salt://mysql/files/my.cnf 
  
server_mysql: 
  service.running:
    - name: mysqld 
    - enable: True
    - reload: True 
    - watch: 
      - file: /etc/my.cnf 
   
