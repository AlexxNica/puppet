# analytics servers (RT-1985)

@monitor_group { "analytics-eqiad": description => "analytics servers in eqiad" }

class role::analytics {
	system_role { "role::analytics": description => "analytics server" }
	$nagios_group = "analytics-eqiad"

	include standard,
		admins::roots,
		accounts::diederik,
		accounts::dsc,
		accounts::otto
	
	sudo_user { [ "diederik", "dsc", "otto" ]: privileges => ['ALL = (ALL) NOPASSWD: ALL'] }

	# Install Sun/Oracle Java JDK on analytics cluster
	java { "java-6-oracle": 
		distribution => 'oracle',
		version      => 6,
	}

	# We want to be able to geolocate IP addresses
	include geoip

	# udp-filter is a useful thing!
	include misc::udp2log::udp_filter
}
