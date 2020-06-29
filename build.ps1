$ErrorActionPreference = "Stop"
#Força o Powershell a parar caso ocorram erros. O padrão é pular para a proxima linha.

#Variaveis
$release = gc release
$date = [Xml.XmlConvert]::ToString((get-date),[Xml.XmlDateTimeSerializationMode]::Utc)

#build
docker build --build-arg BUILD_DATE=$date --build-arg PHP_VERSION="7.3.14-r0" -t $release .

#push
docker push $release