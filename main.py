# Script pour obtenir un prompt de l'utilisateur en Python
from wordlist import wordlist_generate
from bruteforce import bruteforce
from crack import crack_hash
def obtenir_prompt():
    prompt = input("Entrez votre prompt : ")
    return prompt
    
def print_choice_result(prompt_result):
    if prompt_result == "1":
        crack_hash()
    elif prompt_result == "2":
        bruteforce()
    elif prompt_result == "3":
        wordlist_generate()
    else:
        print("Choix invalide")
    
print("##############################")
print("Boite à outils de pentest")
print("##############################")
print("1 - Crack")
print("2 - Bruteforce")
print("3 - Génération de wordlist")

prompt_utilisateur = obtenir_prompt()

print_choice_result(prompt_utilisateur)
