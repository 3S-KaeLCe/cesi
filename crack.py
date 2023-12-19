import hashlib


def crack_hash():
    print("Fonctions disponibles dans l'outil de cracking :")
    print("1 - Génération de hash MD5")
    print("2 - Crack de hash MD5")
    choix = input("Veuillez choisir une option: ")
    if choix == "1":
        md5_encrypt()
    elif choix == "2":
        md5_crack_password()
    else:
        print("Mauvais choix")
    
    
def md5_encrypt():
    password = input("Entrez votre mot de passe : ")
    print("MD5 de votre mot de passe :", hashlib.md5(password.encode()).hexdigest()) 
    
def md5_crack_password():
    hash = input("Veuillez renseigner le hash: ")
    with open("french_passwords_top20000.txt", 'r', encoding="utf-8") as fichier:
        for ligne in fichier:
            ligne_hash = hashlib.md5(ligne.strip().encode()).hexdigest()
            if ligne_hash == hash:
                print("MDP trouvé : ", ligne)
                break
    

        