Write-Host "Installing Launch4J"
$launch4jLink = "https://downloads.sourceforge.net/project/launch4j/launch4j-3/3.50/launch4j-3.50-win32.zip"
$launch4jZip = "launch4j.zip"
Invoke-WebRequest -UserAgent "Wget" -Uri $launch4jLink -OutFile $launch4jZip -MaximumRedirection 3
Expand-Archive -Path $launch4jZip -DestinationPath .
Remove-Item $launch4jZip

Write-Host "Downloading JRE"
$jreVersion = "24"
$jreZip = "OpenJRE$jreVersion.zip"
Invoke-WebRequest `
  -Uri "https://api.adoptium.net/v3/binary/latest/$jreVersion/ga/windows/x64/jre/hotspot/normal/eclipse" `
  -OutFile $jreZip
Expand-Archive -Path $jreZip -DestinationPath .
Remove-Item $jreZip


$version = "v1.8.1"
$realmSharkName = "Tomato-$Version" 
$realmSharkJar = "$realmSharkName.jar"
Write-Host "Installing RealmShark $realmSharkName"
Invoke-WebRequest "https://github.com/X-com/RealmShark/releases/download/$version/$realmSharkJar" -OutFile $realmSharkJar
Write-Host "Packaging RealmShark into Java Executable"

launch4j\launch4jc.exe RealmSharkl4j.xml
if (Test-Path -Path "RealmShark.exe") {
    Remove-Item $realmSharkJar # Remove the .jar because now we have the .exe!
}
