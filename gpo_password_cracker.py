
import base64
from Crypto.Cipher import AES
from Crypto.Util.Padding import pad, unpad

import sys

def main():
    if len(sys.argv) > 1:
        pw_enc_b64 = sys.argv[1]
        # AES Key : https://docs.microsoft.com/en-us/openspecs/windows_protocols/ms-gppref/2c15cbf0-f086-4c74-8b70-1f2fa45dd4be)
        key = b'\x4e\x99\x06\xe8\xfc\xb6\x6c\xc9\xfa\xf4\x93\x10\x62\x0f\xfe\xe8\xf4\x96\xe8\x06\xcc\x05\x79\x90\x20\x9b\x09\xa4\x33\xb6\x6c\x1b'
        # Fixed null IV
        iv = b'\x00' * 16
        # Padding the ciphertext
        pad = len(pw_enc_b64) % 4
        if pad == 1:
            pw_enc_b64 = pw_enc_b64[:-1]
        elif pad == 2 or pad == 3:
            pw_enc_b64 += '=' * (4 - pad)
        pw_enc = base64.b64decode(pw_enc_b64)
        # Create context
        ctx = AES.new(key, AES.MODE_CBC, iv)
        # Decryption
        password = unpad(ctx.decrypt(pw_enc), ctx.block_size).decode('utf-16-le')
        print(password)
    else:
        print("Aucun paramètre n'a été passé.")

if __name__ == "__main__":
    main()
