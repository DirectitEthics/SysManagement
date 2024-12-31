#!/bin/bash

# Gemini Advanced AI Assistance
# https://gemini.google.com/app/

# --- Input ---
# Get the file to encrypt
read -p "Enter the path to the file you want to encrypt: " file_to_encrypt  

# Get the destination directory or device
read -p "Enter the destination directory or device: " destination            


# --- Encryption ---
# Generate a random encryption key using /dev/urandom
encryption_key=$(head /dev/urandom | tr -dc A-Za-z0-9 | head -c 32)        # Generate a 32-character alphanumeric key


# Encrypt the file using OpenSSL (install with: `sudo apt install openssl`)
openssl enc -aes-256-cbc -salt -in "$file_to_encrypt" -out "$destination/encrypted_file" -pass pass:"$encryption_key"  # Encrypt with AES-256, salt for added security


# --- Key Storage ---
# Store the encryption key in a text file in the Documents directory
echo "$encryption_key" > ~/Documents/encryption_key.txt                     # Save the key


# --- Password Protection (HOLD OFF - See below) ---
# Add a password to the key file (replace 'your_password' with your actual password)
# sudo zip --password "your_password" ~/Documents/encryption_key.txt.zip ~/Documents/encryption_key.txt


# --- Cleanup ---
# (Optional) Remove the original unencrypted file
# rm "$file_to_encrypt"                                                    


echo "File encrypted and key stored in ~/Documents/encryption_key.txt"
