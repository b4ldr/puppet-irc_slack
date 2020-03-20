# Reference
<!-- DO NOT EDIT: This document was generated by Puppet Strings -->

## Table of Contents

**Classes**

* [`irc_slack`](#irc_slack): install https://github.com/insomniacslk/irc-slack

**Data types**

* [`Irc_slack::Loglevel`](#irc_slackloglevel): 

## Classes

### irc_slack

install https://github.com/insomniacslk/irc-slack

#### Parameters

The following parameters are available in the `irc_slack` class.

##### `source_dir`

Data type: `Stdlib::Unixpath`

directory to download and managed the source code

Default value: '/usr/local/src/irc-slack'

##### `home_dir`

Data type: `Stdlib::Unixpath`

the home directory for the irc-slack user

Default value: '/var/lib/irc-slack'

##### `user`

Data type: `String`

the user to run irc-slack as

Default value: 'irc-slack'

##### `listen`

Data type: `Stdlib::IP::Address`

the ip address for irc-slack to listen on

Default value: '127.0.0.1'

##### `port`

Data type: `Stdlib::Port`

the port or irc-slack to listen on

Default value: 6666

##### `server_name`

Data type: `Stdlib::Fqdn`

the server name irc-slack sends to irc

Default value: $facts['networking']['fqdn']

##### `source`

Data type: `Stdlib::HTTPUrl`

the location of the irc-slack git repo

Default value: 'https://github.com/insomniacslk/irc-slack.git'

##### `branch`

Data type: `String`

the bit branch to use when downloading irc-slack

Default value: 'master'

##### `log_level`

Data type: `Irc_slack::Loglevel`

the log_level to run irc-slack as

Default value: 'warn'

## Data types

### Irc_slack::Loglevel

The Irc_slack::Loglevel data type.

Alias of `Enum['error', 'warn', 'info', 'debug']`
