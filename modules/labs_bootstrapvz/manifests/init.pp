class labs_bootstrapvz() {
    package { 'bootstrap-vz':
        ensure => present,
    }

    package { 'zerofree':
        ensure => present,
    }

    $bootstrap_filepath = '/etc/bootstrap-vz/'

    file { $bootstrap_filepath:
        ensure => directory
    }

    file { "${bootstrap_filepath}/manifests":
        ensure => directory,
        require => File[$bootstrap_filepath],
    }

    file { "${bootstrap_filepath}/firstscripts":
        ensure => directory,
        require => File[$bootstrap_filepath],
    }

    file { "${bootstrap_filepath}/puppet":
        ensure => directory,
        require => File[$bootstrap_filepath],
    }

    file { "${bootstrap_filepath}/manifests/labs-jessie.manifest.yaml":
        mode    => '0444',
        source  => 'puppet:///modules/labs_bootstrapvz/labs-jessie.manifest.yaml',
        require => File["${bootstrap_filepath}/manifests"],
    }

    file { "${bootstrap_filepath}/firstscripts/firstboot.sh":
        mode    => '0555',
        source  => 'puppet:///modules/labs_bootstrapvz/firstboot.sh',
        require => File["${bootstrap_filepath}/firstscripts"],
    }

    file { "${bootstrap_filepath}/firstscripts/firstbootrc":
        mode    => '0555',
        source  => 'puppet:///modules/labs_bootstrapvz/firstbootrc',
        require => File["${bootstrap_filepath}/firstscripts"],
    }

    file { "${bootstrap_filepath}/install_sudo.sh":
        mode    => '0555',
        source  => 'puppet:///modules/labs_bootstrapvz/install_sudo.sh',
        require => [Package['bootstrap-vz'],
                    File["${bootstrap_filepath}"],
                    ],
    }

    $projectregex = "s/${instanceproject}/_PROJECT_/g"
    $fqdnregex = "s/${::ec2id}.${::domain}/_FQDN_/g"
    $masterregex = "s/${servername}/_MASTER_/g"

    Exec { path => '/bin' }

    exec { "cp /etc/security/access.conf ${bootstrap_filepath}/access.conf":
    } ~>

    exec { "sed -i '${projectregex}' ${bootstrap_filepath}/access.conf":
    }

    exec { "cp /etc/nslcd.conf ${bootstrap_filepath}/nslcd.conf":
    } ~>

    exec { "sed -i '${projectregex}' ${bootstrap_filepath}/nslcd.conf":
    }

    exec { "cp /etc/ldap/ldap.conf ${bootstrap_filepath}/nss_ldap.conf":
    } ~>

    exec { "sed -i '${projectregex}' ${bootstrap_filepath}/nss_ldap.conf":
    }

    exec { "cp /etc/puppet/puppet.conf ${bootstrap_filepath}/puppet/puppet.conf":
        require => File["${bootstrap_filepath}/puppet"],
    } ~>

    exec { "sed -i '${projectregex}' ${bootstrap_filepath}/puppet/puppet.conf":
    } ~>

    exec { "sed -i '${fqdnregex}' ${bootstrap_filepath}/puppet/puppet.conf":
    } ~>

    exec { "sed -i '${masterregex}' ${bootstrap_filepath}/puppet/puppet.conf":
    }

    # The bootstrap run tends to time out during apt
    apt::conf { 'bootstrap-timeout':
        priority => '99',
        key      => 'Acquire::http::Timeout',
        value    => '3000',
    }
}
