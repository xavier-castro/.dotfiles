# README

## TODO

- [ ] Grab all configs you think you'd like to keep before deleting lazyvim branch
- [ ] Learn power of primeagen plugins (UndoTree, Trouble, QF)
- [ ] Stow fish config correctly
- [ ] Stow ghostty config correctly
- [ ] Edit Zenmode to how you like it
- [ ] Maybe add more helpful telescope binds?
- [ ] Create personal journaling folder (private)

## Cli Commands

Homebrew `/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"`

```bash
brew install fish exa fzf z neovim ripgrep zoxide
```

## Neat Commands I need to use more

`Alt+l` -> In fish shell, lists whats in the current directory you are in

## CLI Essentials

- [Zoxide]
- [Fzf]
- [Ripgrep]
- [exa]
- [Neovim]

## Mac Setup

- [Homebrew](https://brew.sh/)
- [UTM](https://mac.getutm.app/)
- [Karabiner-Elements](https://pqrs.org/osx/karabiner/)
- [Rectangle Pro](https://rectangleapp.com/pro)
- [Raycast](https://raycast.com/)

### Karabiner

`cd` into the karabiner folder and run the following command:

```bash
yarn
yarn run build
```

# SSH from MacBook Pro to Windows 11 (Including WSL Access)

This guide explains how to SSH from a MacBook Pro into a Windows 11 computer and access WSL (Windows Subsystem for Linux).

---

## 1. Enable SSH Server on Windows

1. **Install the OpenSSH Server on Windows:**

   - Open **Settings** → **Apps** → **Optional Features**.
   - Search for **OpenSSH Server**. If it’s not installed:
     - Click **Add a feature**.
     - Search for "OpenSSH Server" and install it.

2. **Start and Enable the SSH Server:**

   - Open **PowerShell** as Administrator and run:

     ```powershell
     Start-Service sshd
     Set-Service -Name sshd -StartupType Automatic
     ```

   - Allow SSH traffic through the Windows firewall:

     ```powershell
     New-NetFirewallRule -Name sshd -DisplayName "OpenSSH Server" -Enabled True -Direction Inbound -Protocol TCP -Action Allow -LocalPort 22
     ```

3. **Check Your Windows Computer’s IP Address:**

   - Open **Command Prompt** and run:

     ```cmd
     ipconfig
     ```

   - Note the IPv4 address of your computer (e.g., `192.168.1.100`).

---

## 2. Configure WSL to Work with SSH

1. **Install WSL and Set Up a Distro:**

   - If WSL is not installed, run the following in **PowerShell**:

     ```powershell
     wsl --install
     ```

   - Set up your preferred Linux distribution (e.g., Ubuntu).

2. **Start the WSL Service:**

   - Ensure WSL is running by opening a WSL terminal.

3. **Optional: Enable Passwordless Login with SSH Key:**

   - Generate an SSH key on your Mac:

     ```bash
     ssh-keygen -t rsa
     ```

   - Copy the public key to WSL:

     ```bash
     ssh-copy-id <username>@<windows-ip>
     ```

   - Replace `<username>` with your WSL username and `<windows-ip>` with your Windows computer’s IP address.

---

## 3. SSH into Windows and Access WSL

1. **From Your MacBook Pro:**

   - Open the **Terminal** app on macOS.
   - Connect to your Windows computer:

     ```bash
     ssh <username>@<windows-ip>
     ```

   - Replace `<username>` with your Windows account username.

2. **Switch to WSL from SSH:**

   - Once connected to Windows, type:

     ```cmd
     wsl
     ```

   - This will start the WSL shell inside your SSH session.

---

## 4. Optional Tweaks

### Directly SSH into WSL

- Find your WSL’s IP address:

  ```bash
  ip addr
  ```

  Or use:

  ```bash
  cat /etc/resolv.conf
  ```

- Configure your Windows SSH server to forward requests to WSL.
- Alternatively, set up an SSH server directly within WSL for direct access.

### Improve Convenience with `.ssh/config`

- Edit the SSH config file on your MacBook:

  ```bash
  nano ~/.ssh/config
  ```

- Add an entry:

  ```text
  Host windows-wsl
      HostName <windows-ip>
      User <username>
  ```

- Save and connect using:

  ```bash
  ssh windows-wsl
  ```

---

Follow these steps, and you should be able to SSH from your MacBook Pro to Windows 11 and access WSL!
