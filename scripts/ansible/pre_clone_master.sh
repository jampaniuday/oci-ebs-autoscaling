#/bin/sh

export ANSIBLE_CONFIG=./ansible.cfg
export ANSIBLE_HOST_KEY_CHECKING=False
ansible-playbook preclone_master.yml -i inventory -vvv