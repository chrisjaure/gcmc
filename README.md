GCMC
====

Google Compute Engine Minecraft Provisioner.

Dependencies
------------

- [Terraform](https://www.terraform.io/intro/getting-started/install.html) >= v0.6
- [Ansible](http://docs.ansible.com/ansible/intro_installation.html#installation) >= v1.5

If you've got `brew` on Mac OS X, you can run the following to grab the dependencies:
```
brew update
brew install terraform ansible
```

Setup
-----

- Create a new Google Cloud project if you don't have one yet. Make sure the Compute Engine API is enabled.
- Download your Google Cloud [json credentials](https://developers.google.com/identity/protocols/application-default-credentials#howtheywork).
- Copy `terraform.tfvars.example` to `terraform.tfvars` and fill in your info. Have a look at `variables.tf` for optional variables you can set.

Usage
-----

```
terraform apply
ansible-playbook -i hosts provision.yml
```

Once that successfully completes, run the following to get the ip address of your brand new minecraft server!
```
terraform output ip
```

### Forge Example

A sample Forge configuration has been provided in `minecraft.yml.example`. To use it, copy it to `minecraft.yml`, change any options, and run:
```
ansible-playbook -i hosts --extra-vars "@minecraft.yml" provision.yml
```

Configuration
-------------

There are three levels of configuration: Terraform, Ansible, and Docker.

### Terraform

Edit `terraform.tfvars` to modify the following:

- `account_file` - path to Google Compute credentials file
- `ssh_path` - path to your public ssh key
- `project` - Google Compute Project name
- `region` - Region to create Google Compute Engine instance in. Available options are "us-central1", "europe-west1", and "east-asia1". Defaults to "us-central1".
- `disk_image` - Image to create instance from. Defaults to "coreos-stable-633-1-0-v20150414".
- `machine_type` - Google Compute Engine machine type. Defaults to "n1-standard-1".

### Ansible

[Pass in extra vars](http://docs.ansible.com/playbooks_variables.html#passing-variables-on-the-command-line) when running the `provision.yml` playbook. 

- `docker_name` - Name of the docker container. Defaults to "minecraft".
- `docker_image` - Docker image to pull. Defaults to "itzg/minecraft-server".
- `docker_volume` - Volume on host to persist data. Defaults to "/home/core/minecraft".
- `minecraft_data` - Path to Minecraft archive data to upload, useful for adding mods or a pregenerated world. Be sure to archive the contents of the minecraft folder and not the folder itself.
- `minecraft_opts` - Options to pass to docker image. See Docker configuration below.
- `minecraft_mem` - Memory to provide Minecraft jar. Defaults to 3/4 the total memory of the machine.

### Docker

The docker image [`itzg/minecraft-server`](https://registry.hub.docker.com/u/itzg/minecraft-server/) provides aditional configuration. The following options are set by default:

- `EULA=TRUE` - Accept the EULA for Minecraft 1.8 and up.
- `JVM_OPTS=-Xmx{{ minecraft_mem }}M -Xms{{ minecraft_mem }}M` - Set the JVM memory.
