# Productivity Booster

This script is designed to enhance your productivity on macOS by modifying the `/etc/hosts` file to block access to certain websites. It adds entries for popular social media platforms, such as Instagram, Facebook, and Twitter, redirecting them to localhost or blocking them completely.

## Installation

To use the Productivity Booster script, follow these steps:

1. Download the `focus.sh` file from this repository.

2. Open Terminal on your macOS.

3. Navigate to the directory where you downloaded the `focus.sh` file:
   ```bash
   cd ~/Downloads
   ```

4. Make the script executable by running the following command in the Terminal:
   ```bash
   chmod +x focus.sh
   ```

5. Create shorthand for faster access from Terminal.
Edit `~/.profile` (or `~/.zprofile` if you're using [zshell](https://ohmyz.sh/)) adding the following:
   ```bash
   alias focus="sudo ~/Downloads/focus.sh"
   ```

## Usage

1. Open the file focus.sh in your favorite text editor, find the ENTRIES variable and add the domains (websites without `https://`) you wish to block to the list, as shown with any of the examples:
```
# Define the entries to be added to the hosts file
ENTRIES=$(cat <<EOF
127.0.0.1    www.instagram.com instagram.com
::1    www.facebook.com facebook.com fb.com
0.0.0.0    twitter.com www.twitter.com

EOF
)
```
2. Save the file and open Terminal on your macOS.

3. Run the `focus` command. If alias is setup correctly (see Installation #5), this will block the eariler defined websites. Running the same command again makes the websites accessible again.

To run the script without alias, navigate to the directory with the `focus.sh` file and run the script as root or using sudo:

```bash
sudo ./focus.sh
```

You may be prompted to enter your password to gain root privileges.


## Important Notes

- It's a good practice to back up your `/etc/hosts` file for a good measure.

- If access is not removed/restored immediately, try restarting your browser. Alternatively try playing around with the IP addresses with one of the following:
```
# IPv4 redirect to localhost, should work in most cases. Add as many domains in one line as you like
127.0.0.1    www.instagram.com instagram.com
# IPv6 redirect to localhost if IPv4 redirect doesn't work
::1    www.facebook.com facebook.com fb.com
# redirect to wildcard IP address for those stubborn websites
0.0.0.0    twitter.com www.twitter.com
```

- The script modifies the `/etc/hosts` file, which requires root privileges. Ensure you run the script as root or using sudo.

- The script uses the placeholders `# @@@ PRODUCTIVITY BOOSTER @@@` and `# @@@ PRODUCTIVITY BOOSTER END @@@` to identify the block of entries added by the script. Do not modify these placeholders manually in the `/etc/hosts` file, as it may cause issues with the script's functionality.

- The script adds entries for blocking Instagram, Facebook, and Twitter as example entries. You can customize the `ENTRIES` variable in the script to add or remove entries for other websites. Make sure to follow the format `IP_ADDRESS    DOMAIN` for each entry.

- The changes made by this script only affect the local machine where it is executed. Other devices on the network will not be affected.
