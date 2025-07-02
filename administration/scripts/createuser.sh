#!/bin/bash

export PATH=$PATH:/usr/sbin


if [ "$(id -u)" -ne 0 ]; then #check if srcipt is run as root
    echo "This script must be run as root. Use sudo."
    exit 1
fi

read -p $'Please select a new username:\n' username


if id "$username" &>/dev/null; then #id + username checks  validity of user then sends to  garbage
    echo "User '$username' already exists."
    exit 1
fi

read -s -p $'Please select a password:\n' password # -s=for clear pswd  -p= need to be right before text prompt
echo  # Add newline after silent input

# Create user
useradd -m -s /bin/bash "$username" #-m= adds to home dir -s bion/bash=add to to bin/bash dir


echo "$username:$password" | chpasswd #chpasswd need  format username:password


echo "User '$username' created successfully."

return