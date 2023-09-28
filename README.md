# IPRUNNER

![Screenshot from 2023-09-29 00-10-53](https://github.com/strangedreamer4/IPRUNNER/assets/82073583/a45c488e-3775-4d84-b7e1-03cd8229defe)

   provide a brief distribution guide for your network toolkit script and instructions on how to run it.

**Distribution Guide:**
f you want to add xterm functionality to your script, you can follow these steps to integrate xterm into your existing script:

1. **Install xterm (if not already installed):**
   Ensure that xterm is installed on your system. You can typically install it using your system's package manager. For example, on Ubuntu or Debian-based systems, you can use:

   ```bash
   sudo apt-get install xterm
   ```

2. **Package Dependencies:**
   Ensure that the following packages are installed on the system where you plan to run the script:
   - `bash`: The script is written in Bash.
   - `nc` (Netcat): Used for port checking.
   - `nmap`: Used for network scanning.
   - `xterm`: Used for displaying network scan results in a separate window.
   - `firefox` (optional): Used to open a web browser for port 80.
   - `ssh` (optional): Used to open an SSH terminal for port 22.

3. **Install Dirsearch (optional):**
   If you plan to use Dirsearch, make sure it is installed. You can typically install it via apt:
   ```
   sudo apt install dirsearch
   ```

4. **Download the Script:**
   Download the script and save it to a directory on your system.

5. **Make the Script Executable:**
   Use the `chmod` command to make the script executable:
   ```
   chmod +x iprunner.sh
   ```

**How to Run the Script:**

1. Open a terminal.

2. Navigate to the directory where you saved the script using the `cd` command:
   ```
   cd /IPRUNNER
   ```

3. Run the script using the `./` prefix:
   ```
   ./iprunner.sh
   ```

4. Follow the on-screen instructions:
   - Enter the target IP address when prompted.
   - The script will perform the following tasks:
     - Start an Nmap scan in the background.
     - Start a Dirsearch scan in the background.
     - Check if the target IP is live.
     - Check if port 80 (HTTP) is open and open Firefox if it is.
     - Check if port 22 (SSH) is open and open an SSH terminal if it is.
     - Display the results in separate xterm windows.
     - Log the results in the `network_tool.log` file in the same directory where the script is located.

5. Wait for the script to complete its tasks, and the results will be displayed in separate xterm windows.

6. After the script finishes, you can find the log file, `network_tool.log`, in the same directory. It will contain the results of the Nmap and Dirsearch scans, as well as the status of the IP and ports.

7. To view the Dirsearch results, you can navigate to `/home/@username/.dirsearch/reports` as indicated in the script's output.

Please note that for some functionalities, such as opening a web browser or an SSH terminal, you may need to have the respective applications (e.g., Firefox, SSH client) installed and configured on your system. Also, ensure that you have the necessary permissions to run these tools and open xterm windows.

