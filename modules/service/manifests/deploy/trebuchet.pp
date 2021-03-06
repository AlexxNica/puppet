# == Define service::deploy::trebuchet
#
# Deploys services on nodes via trebuchet package provider.
#
# This class should be removed once scap deploys all services.
#
define service::deploy::trebuchet {
    require ::service::deploy::common
    if ! defined(Package[$title]) {
        package { $title:
            provider => 'trebuchet',
        }
    }
}
