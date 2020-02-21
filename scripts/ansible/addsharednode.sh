#/bin/sh

export ANSIBLE_CONFIG=./ansible.cfg
export ANSIBLE_HOST_KEY_CHECKING=False
ansible-playbook addsharednode.yml -i inventory -vvv
