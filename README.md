# ubuntu-init

This repository contains scripts and configurations for initializing a new Ubuntu server using Ansible.

This init script will:

- Create a non-root user and add it to the sudo group
- Copy your local SSH public key to the remote server for both root and the new user
- Disable root login and password-based login
- Update the server
- Install docker, docker compose
- Add the user to the docker group
- Set up and configure the UFW to only allow SSH connections and deny any other requests
- Add useful aliases to the bash profile

## Prerequisites

- Ansible installed on the local machine
- `sshpass` program installed (you can install it with `sudo apt-get install sshpass` on Ubuntu or `brew install sshpass` on macOS)
- IP and root password of the target server
- Your local SSH public key (`~/.ssh/id_rsa.pub`)

## Usage

1. Clone the repository:
   ```
   git clone https://github.com/oseau/ubuntu-init.git
   ```

2. Create and edit the `inventory/hosts.ini` file:
   ```
   cp inventory/hosts.ini.example inventory/hosts.ini
   ```
   Then edit `inventory/hosts.ini` with your specific values.

3. Run the playbook using the Makefile:
   ```
   make run
   ```

4. Wait for the playbook to finish.

5. Connect to the server with the new user using your local SSH key:
   ```
   ssh <non_root_user>@<server_ip>
   ```

## Project Structure

```
ubuntu-init/
├── .gitignore
├── inventory/
│   └── hosts.ini
├── Makefile
├── playbooks/
│   └── main.yml
├── roles/
│   ├── docker/
│   │   └── tasks/
│   │       └── main.yml
│   ├── system/
│   │   └── tasks/
│   │       └── main.yml
│   ├── ufw/
│   │   └── tasks/
│   │       └── main.yml
│   └── user_and_ssh/
│       └── tasks/
│           └── main.yml
└── README.md
```

## Security Considerations

For the initial setup, host key checking is disabled to allow for password authentication. After the initial setup, it's recommended to re-enable host key checking for improved security.
