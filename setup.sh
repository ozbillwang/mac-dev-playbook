#!/bin/bash -e

DIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)

# Download and install Command Line Tools
if [[ ! -x /usr/bin/gcc ]]; then
	xcode-select --install
fi

# Download and install Homebrew
if [[ ! -x /usr/local/bin/brew ]]; then
	ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

# Modify the PATH
export PATH=/usr/local/bin:$PATH

# Download and install Ansible
if [[ ! -x /usr/local/bin/ansible ]]; then
	brew install ansible
fi

# Run local_mac_setup playbook
#ansible-playbook ansible/playbooks/common.yml
ansible-playbook -i 'localhost,' -c local "$DIR"/ansible/playbooks/site.yml

#ansible-playbook -c local ansible/playbooks/site.yml
# ansible local -m setup -a 'filter=*ipv4*'
# List of tools that was installed by HomeBrew
brew list --versions >brew.log
