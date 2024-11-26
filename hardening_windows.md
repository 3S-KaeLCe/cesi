Commande PS pour verrouiller un compte après 5 tentatives infructueuses

```powershell
net accounts /lockoutthreshold:5
```

Définir des règles pare-feu via Powershell

```powershell
New-NetFirewallRule -DisplayName "Block SMB" -Direction Inbound -Protocol TCP -LocalPort 445 -Action Block
```

Autoriser une IP spécifique à se connecter en RDP

```powershell
New-NetFirewallRule -DisplayName "Allow RDP" -Direction Inbound -Protocol TCP -LocalPort 3389 -RemoteAddress 192.168.10.0/24 -Action Allow
```

Module de politique de sécurité : secpol.msc

Activer BitLocker pour le chiffrement du disque

```powershell
Enable-BitLocker -MountPoint "C:" -EncryptionMethod Aes256 -UsedSpaceOnlyEncryption
```

Bloquer toute exécution de script Powershell

```powershell
Set-ExecutionPolicy Restricted
```

N'autorise que les scripts PS signés par un éditeur de confiance

```powershell
Set-ExecutionPolicy AllSigned
```

Autorise tous les scripts locaux, et les scripts signés s'il sont distants pour tous les utilisateurs

```powershell
Set-ExecutionPolicy RemoteSigned -Scope LocalMachine
```

Désactive les politiques pour l'utilisateur courant

```powershell
Set-ExecutionPolicy Bypass -Scope CurrentUser
```

Pour créer un script signé, utiliser l'Autorité de Certification du domaine et obtenir le certificat de type signature du code sur http://&lt;serveur-CA&gt;/certsrv

Sinon, créer un certificat auto-signé qu'il faudra ensuite importer sur chaque poste nécessitant l'exécution de scripts signés avec ce certificat.

```powershell
$Cert = New-SelfSignedCertificate -Type CodeSigningCert -Subject "CN=EntrepriseCodeSigningCert" -CertStoreLocation Cert:\CurrentUser\My
Export-Certificate -Cert $Cert -FilePath "C:\CertificatPublic.cer"
Import-Certificate -FilePath "C:\CertificatPublic.cer" -CertStoreLocation Cert:\LocalMachine\TrustedPublisher

Get-ChildItem -Path Cert:\CurrentUser\My -CodeSigningCert
Set-AuthenticodeSignature -FilePath "C:\chemin\vers\monScript.ps1" -Certificate (Get-Item Cert:\CurrentUser\My\<Thumbprint>)
```
