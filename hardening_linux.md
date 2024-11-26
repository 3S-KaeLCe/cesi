Définir des permissions

```bash
setfacl -m u:utilisateur:rwx fichier
```

Le propriétaire peut lire, écrire, exécuter, les autres peuvent lire et exécuter

```bash
chmod 755 fichier
```

Retirer le droit d'écriture pour les autres

```bash
chmod o-w fichier
```

changer le propriétaire d'un fichier

```bash
chown utilisateur fichier
```

IPTABLES

```bash
sudo apt update
sudo apt install iptables

#lister les règles
sudo iptables -L -v -n

sudo iptables -P INPUT DROP
sudo iptables -P OUTPUT ACCEPT

#requêtes entrantes localhost
sudo iptables -A INPUT -i lo -j ACCEPT

#requêtes entrantes sur le protocole 443 d'une IP définie
sudo iptables -A INPUT -p tcp --dport 443 -s 192.168.11.24 -j ACCEPT
sudo iptables -A INPUT -p tcp --dport 443 -j DROP
#Autoriser les flux SSH entrants depuis un vlan
sudo iptables -A INPUT -p tcp --dport -s 192.168.10.0/24 22 -j ACCEPT

#Sauvegarder les règles, restaurer et les rendre persistantes
sudo iptables-save > /etc/iptables/rules.v4
sudo iptables-restore < /etc/iptables/rules.v4
sudo apt install iptables-persistent
```

&nbsp;SUDOERS

Fichier dans lequel nous pouvons définir des règles sur l'utilisation du sudo et de commande spécifiques :

/etc/sudoers ou dans /etc/sudoers.d/

```bash
#Limite l'utilisation de sudo que pour ces commandes pour l'utilisateur ciblé
utilisateur  ALL=(ALL)  /bin/ls, /bin/cat, /usr/bin/grep

#Permet d'autoriser le sudo dans mots de passe pour une commande donnée (pour un script amené à lancer cette commande par exemple)
utilisateur  ALL=(ALL)  NOPASSWD: /bin/systemctl restart apache2

#Bloque une commande
utilisateur  ALL=(ALL)  ALL, !/sbin/shutdown
```

&nbsp;

Bloquer complètement une commande à un utilisateur

```bash
setfacl -m u:utilisateur:--- /sbin/shutdown
```
