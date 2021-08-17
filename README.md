# dockerized gdal
Dockerizacion de GDAL con dependencias JAVA incluidas, basado en Alpine.

El proposito es que la misma pueda ser utilizada como base para instalar Geoserver con la [extension de GDAL](https://docs.geoserver.org/stable/en/user/data/raster/gdal.html) incluida.

Criterios:

- Alpine 3.11 -> imagen basada en Alpine como distribucion "liviana".
- OpenJDK -> por preferencia de uso libre, licencia, etc. En la [version 15](https://openjdk.java.net/projects/jdk/15/).
- GDAL -> release 2.1.4 con el fin de mantener compatibilidad con Geoserver 2.16.x o superior.

En sucesivas actualizaciones se publicaran imagenes en Dockerhub, con versiones renovadas de Alpine, OpenJDK y GDAL.