# Contenedor de SQLServer Sin Volumen

``` shell
docker run -e "ACCEPT_EULA=Y" -e "MSSQL_SA_PASSWORD=P@ssw0rd" \
   -p 1435:1433 --name servidordesqlserver \
   -d \
   mcr.microsoft.com/mssql/server:2019-latest
```