#!/bin/bash

# @Autor:            Humberto Serafín Castillo López
# @Fecha creación:   15/08/2021
# @Descripción:

# Si ocurre un error el programa termina
set -e
set -o pipefail

# Comprueba si existe el directorio de PDFs
if [ ! -d "/tmp/bdd/proyecto-final/pdfs" ]; then
  echo "Copiando archivos de muestra..."
  # Crea la ruta de directorios
  mkdir -p /tmp/bdd/proyecto-final/pdfs
  # Descomprime el archivo zip de PDFs
  unzip carga-inicial/pdfs.zip -d /tmp/bdd/proyecto-final
else
  echo "=> Los archivos PDF de muestra ya fueron copiados"
fi

if [ ! -d "/tmp/bdd/proyecto-final/trailers" ]; then
  echo "Copiando archivos de video de muestra"
  mkdir -p /tmp/bdd/proyecto-final/trailers
  unzip carga-inicial/trailers.zip -d /tmp/bdd/proyecto-final
else
  echo "=> Los archivos de video de muestra ya fuero copiados"
fi

# Actualiza los permisos del directorio
chmod -R 755 /tmp/bdd/proyecto-final
