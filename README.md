# yrmcds

#### Table of Contents

1. [Description](#description)
1. [Setup - The basics of getting started with yrmcds](#setup)
    * [What yrmcds affects](#what-yrmcds-affects)
    * [Setup requirements](#setup-requirements)
    * [Beginning with yrmcds](#beginning-with-yrmcds)
1. [Usage - Configuration options and additional functionality](#usage)
1. [Reference - An under-the-hood peek at what the module is doing and how](#reference)
1. [Limitations - OS compatibility, etc.](#limitations)
1. [Development - Guide for contributing to the module](#development)

## Description

This module installs and configures [yrmcds](https://github.com/cybozu/yrmcds), the memcached compatible memory object caching system with master/slave replication.

Basically, the only things modified are the package and the sole config file.

## Usage

The only thing required is to set up the cluster IP that yrmcds will watch. Point your application to this IP; yrmcds will make sure the master role is always on the instance where the virtual IP is present.

class { "yrmcds":
    virtual_ip => 10.0.1.10,
}

## Limitations

Primarily used and testen on Debian. Will probably work on Ubuntu. No
guarantees for others.

