#!/bin/bash
#
# ##synResEnv.sh##
#
# Aquest script copia els fitxers de respostes i enviament del proces de generació de comandes de Farmacia Guerrero.
# Per activar aquest script se li ha de donar permissos de execucio: 
# chmod +x tu_script.sh
# Despres s'ha de programar la seva execucio cada 5 min 
# crontab -e
# En el editor de crontab afegir la seguent linia:
# */5 * * * * /ruta/del/tu_script.sh
# tambe se enregistra les accions de cada execucio en el fitxer /var/log/resenv.log
#
# Inici del script
# Definir las variables
#!/bin/bash
# Prerequisit apt install rsync

# Definir variables

Farmacies=("SBOGuerrero" "SBOGuerrero2" "SBOEuropea")

# Ruta de origen y desti
for Farmacia in "${Farmacies[@]}"; do
    RutaOrigenRes="/var/www/comandes/sapb1/$Farmacia/Respostes"
    RutaOrigenEnv="/var/www/comandes/sapb1/$Farmacia/Enviaments"

    RutaDestiRes="/var/www/comandes/sapb1/web/$Farmacia/Respostes"
    RutaDestiEnv="/var/www/comandes/sapb1/web/$Farmacia/Enviaments"

    # Copia els nous fitxers
    rsync -av --ignore-existing "$RutaOrigenRes/" "$RutaDestiRes/"
    rsync -av --ignore-existing "$RutaOrigenEnv/" "$RutaDestiEnv/"

    # Registrar les accions al log
    echo "$(date +"%Y-%m-%d %H:%M:%S") - Copiats els nous fitxers de $RutaOrigenRes a $RutaDestiRes" >> /var/log/resenv.log
    echo "$(date +"%Y-%m-%d %H:%M:%S") - Copiats els nous fitxers de $RutaOrigenEnv a $RutaDestiEnv" >> /var/log/resenv.log

done
