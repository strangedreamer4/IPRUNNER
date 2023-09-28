#!/bin/bash
# install tools for iprunner
rm -f network_tool.log
sudo apt install xterm -y
sudo apt install dirsearch -y
# Function to log commands and their outputs with timestamps
log_command() {
    timestamp=$(date +"%Y-%m-%d %T")
    echo "[$timestamp] $1" >> network_tool.log
    eval "$1" 2>/dev/null | grep -Ev 'ATTENTION: log' >> network_tool.log
}

# Function to check if an IP is reachable and print "live" or "dead"
check_ping() {
    if ping -c 1 -W 1 "$1" &>/dev/null; then
        echo "[$(date +"%Y-%m-%d %T")] $1 is live"
    else
        echo "[$(date +"%Y-%m-%d %T")] $1 is dead"
    fi
}

# Function to check if a port is open on the IP address
check_port() {
    if nc -z -w1 "$1" "$2"; then
        return 0
    else
        return 1
    fi
}

# Function to generate a random ANSI color code
generate_random_color() {
    colors=("31" "32" "33" "34" "35" "36" "91" "92" "93" "94" "95" "96")
    echo -e "\e[${colors[$((RANDOM % ${#colors[@]}))]}m"
}

# Create a temporary file to store the IP address
tempfile=$(mktemp)

# Create a GTK dialog to input the target IP address
zenity --entry --title "Enter Target IP" --text "Please enter the target IP address:" > "$tempfile"

# Check if the user canceled the dialog
if [ $? -ne 0 ]; then
    echo "User canceled. Exiting..."
    exit 1
fi

# Read the IP address from the temporary file
ip=$(cat "$tempfile")

# Remove the temporary file
rm "$tempfile"

# Clear the terminal
clear
unset MESA_GLTHREAD

# Generate a random color for the banner
random_color=$(generate_random_color)

# ASCII art banner for Network Toolkit
echo -e "${random_color}┏━━┳━━━┳━━━┳┓╋┏┳━┓╋┏┳━┓╋┏┳━━━┳━━━┓"
echo -e "┗┫┣┫┏━┓┃┏━┓┃┃╋┃┃┃┗┓┃┃┃┗┓┃┃┏━━┫┏━┓┃"
echo -e "╋┃┃┃┗━┛┃┗━┛┃┃╋┃┃┏┓┗┛┃┏┓┗┛┃┗━━┫┗━┛┃"
echo -e "╋┃┃┃┏━━┫┏┓┏┫┃╋┃┃┃┗┓┃┃┃┗┓┃┃┏━━┫┏┓┏┛"
echo -e "┏┫┣┫┃╋╋┃┃┃┗┫┗━┛┃┃╋┃┃┃┃╋┃┃┃┗━━┫┃┃┗┓"
echo -e "┗━━┻┛╋╋┗┛┗━┻━━━┻┛╋┗━┻┛╋┗━┻━━━┻┛┗━┛"
echo -e "  Network Toolkit Script"
echo -e "  by StRaNgEdReAmEr"
echo -e "  Version 1.0"
echo -e "-------------------------------------------------------------"

# Create a log file and store the IP address
echo "[$(date +"%Y-%m-%d %T")] Scanning IP address: $ip" > network_tool.log

# Run Nmap with desired options in the background and display output in an xterm window while logging it
xterm -e "nmap -sV -vv -A $ip" &
log_command "nmap -sV -vv -A $ip" &

# Run Dirsearch with the provided URL in the background and display output in an xterm window while logging it
xterm -e "dirsearch -u http://$ip/" &
log_command "dirsearch -u http://$ip/"

# Check if the IP is live or dead and display the result in the background
check_ping "$ip" &

# Check if port 80 is open on the IP address
if check_port "$ip" 80; then
    echo -e "Port 80 is open on $ip. Opening Firefox..."
    firefox "http://$ip" &
else
    echo -e "Port 80 is not open on $ip. Skipping Firefox."
fi

# Check if port 22 (SSH) is open on the IP address
if check_port "$ip" 22; then
    echo -e "Port 22 (SSH) is open on $ip. Opening SSH terminal..."
    xterm -e "ssh $ip" &
else
    echo -e "Port 22 (SSH) is not open on $ip. Skipping SSH."
fi

# Display a message indicating the log file location
echo -e "-------------------------------------------------------------"
echo -e "Results have been logged to network_tool.log"
echo -e "for the output of dirsearch go to (/home/@username/.dirsearch/reports)"
echo -e "\e[0m"  # Reset color to default
sleep 5
exit 0
