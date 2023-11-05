#!/bin/bash
file_conf="postgres.conf"
dir_nginx="/etc/nginx/sites-enabled/"
dir_project="/appli/SpaceProject/database/postgres/" 

echo "Update nginx file conf"
if [ -f $dir_nginx$file_conf ] ; then
    echo "Suppression du fichier existant"
    rm $dir_nginx$file_conf
    echo "Deplacement du fichier mis a jour"
    mv $dir_project$file_conf $dir_nginx
else
    echo "Deplacement du fichier mis a jour"
    mv $dir_project$file_conf $dir_nginx
  
fi
echo "SSL configuration"
echo "1" | certbot  --nginx -d pgadmin.probest-group.com
echo "Reload des deamons nginx"
systemctl reload nginx 
echo "Restart des deamons nginx"
systemctl restart nginx 
echo "Start des deamons nginx"
systemctl start nginx