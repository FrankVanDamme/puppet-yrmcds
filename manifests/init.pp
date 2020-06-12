# Class: yrmcds
# ===========================
#
# Full description of class yrmcds here.
#
# Parameters
# ----------
#
# Document parameters here.
#
# * `sample parameter`
# Explanation of what this parameter affects and what it defaults to.
# e.g. "Specify one or more upstream ntp servers as an array."
#
# Variables
# ----------
#
# Here you should define a list of variables that this module would require.
#
# * `virtual_ip`
#  Virtual IP to listen to (and set up the master at)
#
# * `port`
#  Port for the application to query
#
# * `repl_port`
#  Port for the replication between yrmcds instances
#
# * `counter_port`
#  Port used for counter protocol
#
# Examples
# --------
#
# @example
#    class { 'yrmcds':
#      virtual_ip => '10.1.2.3',
#    }
#
# Authors
# -------
#
# Frank Van Damme <frank.vandamme@gmail.com>
#
# Copyright
# ---------
#
# Copyright 2019 Frank Van Damme, unless otherwise noted.
#
class yrmcds (
    $virtual_ip,
    $port = 11211,
    $repl_port = 11213,
    $counter_port = 11215,
){

    package { "yrmcds":
        ensure =>  installed,
    } -> file { "yrmcds.conf":
        path    => "/etc/yrmcds.conf",
        content => template("$module_name/yrmcds.conf.erb"),
    } ~> service { "yrmcds": ensure =>  running,}


    $yrmcds_service_overrides_content = ".include /lib/systemd/system/yrmcds.service

[Service]
Restart=always
RestartSec=5
	"

    file { "yrmcds_service_overrides":
        path    => "/etc/systemd/system/yrmcds.service",
        content => $yrmcds_service_overrides_content,
        before  => Service["yrmcds"],
    } ~> exec { "yrmcds_systemd_reload":
        command     => "/bin/systemctl daemon-reload",
        refreshonly => true,
    }
}
