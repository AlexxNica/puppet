class firewall::builder {
  file { 
    "/usr/local/fwbuilder.d":
        owner => root,
	group => root,
	mode => 0755,
	ensure => directory;
  }

  # collect all fw definitions
  File <<| tag == 'inboundacl' |>>

  # TODO: add script here that does the work.
      
}

class firewall { 
  # for each inbound ACL create an exported file on the main server 
  define inboundacl ($ruletitle=$title, $ip_address=$ipaddress, port=$port) {
    @@file { 
       "/usr/local/fwbuilder.d/$ruletitle-$port":
          content => "$ruletitle,$ipaddress,$port\n", 
          tag => "inboundacl";
    }
  }
}


class testcase1 {
	include firewall
	firewall::inboundacl {
	   "testbox":
	      ip_address=>"1.2.3.4",
  	      port => 80;
        }
	    
}
