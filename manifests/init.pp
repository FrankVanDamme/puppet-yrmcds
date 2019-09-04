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
# * `sample variable`
#  Explanation of how this variable affects the function of this class and if
#  it has a default. e.g. "The parameter enc_ntp_servers must be set by the
#  External Node Classifier as a comma separated list of hostnames." (Note,
#  global variables should be avoided in favor of class parameters as
#  of Puppet 2.6.)
#
# Examples
# --------
#
# @example
#    class { 'yrmcds':
#      servers => [ 'pool.ntp.org', 'ntp.local.company.com' ],
#    }
#
# Authors
# -------
#
# Author Name <author@domain.com>
#
# Copyright
# ---------
#
# Copyright 2019 Your name here, unless otherwise noted.
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
