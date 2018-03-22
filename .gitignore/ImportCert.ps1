$PWord = ConvertTo-SecureString -String "hGt6Ud3LZa0c" -AsPlainText -Force
Import-PfxCertificate -filepath C:\scripts\Alex-Test.rrts.ca.pfx -CertStoreLocation Cert:\LocalMachine\WebHosting -password: $PWord

$SSLCert = Get-ChildItem -path cert:\LocalMachine\WebHosting | Select Thumbprint;
$Thumbprint = $SSLCert.Thumbprint;
$webServerCert = get-item Cert:\LocalMachine\WebHosting\$Thumbprint;
New-WebBinding -Name "Default Web Site" -IPAddress * -Port 443 -Protocol "https" -HostHeader alex-test.rrts.ca
New-WebBinding -Name "Default Web Site" -IPAddress * -Port 80 -Protocol "http" -HostHeader alex-test.rrts.ca
$bind = Get-WebBinding -Name "Default Web Site" -Protocol https;
$bind.AddSslCertificate($webServerCert.GetCertHashString(), "WebHosting")