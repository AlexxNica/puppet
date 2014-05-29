class puppetmaster::naggen2($ensure = 'present'){

    $packages = ['python-jinja2', 'python-mysql', 'python-sqlalchemy']
    ensure_resource('package', $packages)

    file {'/usr/local/bin/naggen2':
        ensure  => 'present',
        owner   => 'root',
        group   => 'root',
        mode    => '0555',
        source  => 'puppet:///modules/puppetmaster/naggen2',
        require => Package[$packages]
    }
}
