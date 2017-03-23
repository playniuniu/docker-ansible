# Docker for Ansible

This is docker for ansible command

### Useage

1. Prepare your volume file, you can see the **vol_example** folder structure

    ```bash
    mkdir ~/vol/ansible && cp -r vol_example/* ~/vol/ansible/
    ```

2. Run command

    ```bash
    docker run --rm -t -v ~/vol/ansible:/data/ playniuniu/ansible ansible -m ping all
    ```

3. Run playbook

    ```bash
    docker run --rm -t -v ~/vol/ansible:/data/ playniuniu/ansible ansible -m ping all
    ```

### Alias

1. You can alias the docker command in *.bashrc* or *.zshrc* .

    ```bash
    alias myansible='docker run --rm -t -v ~/vol/ansible:/data/ playniuniu/ansible ansible'
    alias myansible-playbook='docker run --rm -t -v ~/vol/ansible:/data/ playniuniu/ansible ansible-playbook'
    ```

2. Then use the alias like below:

    ```bash
    myansible -m all ping
    myansible-playbook -s /data/ansible/apt.yml
    ```
