Vagrant-Config
==============

My vagrant box config/provsioning 


Requires [VirtualBox](https://www.virtualbox.org/), and [Vagrant](http://www.vagrantup.com/) to be installed. 

Setup 
=====

The VagrantFile is configured to mount the parent directory of where the VagrantFile is in the directory tree. 

In example: 
```
  -Sites/
    -MyAwesomeProject/
    -ThisIsWhereVagrantLives/
      -VagrantFile
      -provision.sh
    -AnotherAwesomeProject/
```

To get the vagrant instance setup and running, `cd` into the directory with that contains your `VagrantFile` and run `vagrant up`.

This will take a few minutes the first time. Once it's finished, run `vagrant provision` to run the provisioning script.

This will install LAMP and some related dependencies. 

Aliases
=======

Assuming your vagrant folder is in `~sites/server/` the following aliases can be added to your `.bashrc` or equivilant file, so you can vagrant like a boss. 
```
alias vup="(cd ~/sites/server && vagrant up)"
alias vstat="(cd ~/sites/server && vagrant status)"
alias vhalt="(cd ~/sites/server && vagrant halt)"
alias vreload="(cd ~/sites/server && vagrant reload)"
alias vprovision="(cd ~/sites/server && vagrant provision)"
alias vssh="(cd ~/sites/server && vagrant ssh)"
```





    
