# #!/bin/bash

# # Extract username from the shell prompt
# current_username=$(echo $PS1 | awk -F: '{print $1}' | awk '{print $NF}')

# # Extract usernames from /etc/passwd
# usernames=$(awk -F: '{ print $1 }' /etc/passwd)

# # Check if the current_username is in the list of usernames
# if echo "$usernames" | grep -q "$current_username"; then
#   echo "Current user: $current_username"
# else
#   echo "Current user $current_username not found in /etc/passwd."
# fi


#!/bin/bash

# Try to get the current user using whoami
# current_username=$(whoami)

# # If whoami doesn't work, extract username from the shell prompt
# if [ -z "$current_username" ]; then
#   current_username=$(echo $PS1 | awk -F: '{print $1}' | awk '{print $NF}')
# fi

# # Extract usernames from /etc/passwd
# usernames=$(awk -F: '{ print $1 }' /etc/passwd)

# # Check if the current_username is in the list of usernames
# if echo "$usernames" | grep -q "$current_username"; then
#   echo "Current user: $current_username"
# else
#   echo "Current user $current_username not found in /etc/passwd."
# fi

#!/bin/bash

# Extract usernames from /etc/passwd
# usernames=$(awk -F: '{ print $1 }' /etc/passwd)

# # Print the list of usernames
# echo "List of users on the system:"
# echo "$usernames"
#!/bin/bash

# Get the current user using whoami
current_username=$(whoami)

# If whoami doesn't work, extract username from the shell prompt
if [ -z "$current_username" ]; then
  current_username=$(echo $PS1 | cut -d':' -f1 | awk '{print $NF}')
fi

# Extract and print all usernames from /etc/passwd
echo "All users on the system:"
awk -F: '{ print $1 }' /etc/passwd

# Check if the current_username is in the list of usernames
if echo "$current_username" | grep -q -w -F -x "$(awk -F: '{ print $1 }' /etc/passwd)"; then
  echo "Current user: $current_username"
else
  echo "Current user $current_username not found in /etc/passwd."
fi

