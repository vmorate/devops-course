# devops-course
A repository to explain the features of Vagrant, Puppet 4 and Jenkins

## Synopsis
Repository to show hands on how puppet works as provisioner of a vagrant image creating a Jenkins artifact inside the vagrant virtual machine.

## Code Example

Show what the library does as concisely as possible, developers should be able to figure out **how** your project solves their problem by looking at the code example. Make sure the API you are showing off is obvious, and that your code is short and concise.

## Motivation

This project has been created to be a guide for people who want to be introduced in Devops procedures and philosophy

## Installation

### Clone repository created before
git clone git@github.com:vmorate/devops-test.git

### https://atlas.hashicorp.com/puppetlabs/boxes/centos-7.2-64-puppet
vagrant init puppetlabs/centos-7.2-64-puppet; vagrant up --provider virtualbox

### Create Repository infraestructure to support Puppet 4 Environments feature
/environments/$Environment/manifest/
/environments/$Environment/modules/
/environments/$Environment/environment.conf

### Add Hiera structure
hiera.yaml
hieradata/common.yaml
hieradata/environments/
hieradata/nodes/

### Search for the best Jenkins module in puppet forge https://forge.puppet.com

### Execute puppet module install to install jenkins module following the best module found https://forge.puppet.com/rtyler/jenkins
.\puppet.bat module install rtyler-jenkins --version 1.7.0 --modulepath 'C:\Users\Victor\Repositories\devops-course\environments\vagrant\modules\'

### Create yaml file for the vagrant box and add Jenkins class
hieradata/nodes/centos72.vagrant.yaml

## Tests

Describe and show how to run the tests with code examples.

## Contributors

Victor Morate

## License

Vagrant from HashiCorp, Puppet

