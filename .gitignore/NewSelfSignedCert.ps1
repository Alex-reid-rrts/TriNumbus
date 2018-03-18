New-SelfSignedCertificate -DnsName "trinimbus.rrts.tech" -CertStoreLocation "cert:\LocalMachine\My"
$SSLCert = Get-ChildItem -path cert:\LocalMachine\my | Select Thumbprint;
$Thumbprint = $SSLCert.Thumbprint;
$webServerCert = get-item Cert:\LocalMachine\My\$Thumbprint;
New-WebBinding -Name "Default Web Site" -IPAddress * -Port 443 -Protocol "https"
$bind = Get-WebBinding -Name "Default Web Site"-Protocol https;
$bind.AddSslCertificate($webServerCert.GetCertHashString(), "my")