class sysconfig::network_interface($iname='eth0') {

  augeas{ $iname :
    context => '/files/etc/sysconfig/network-scripts',
    changes => [
        "rm ifcfg-$iname/NOZEROCONF",
	"set ifcfg-$iname/NOZEROCONF[. = \"YES\"] \"YES\"",	
        "rm ifcfg-$iname/NM_CONTROLLED", 
	"set ifcfg-$iname/NM_CONTROLLED[. = \"NO\"] \"NO\"",
        "rm ifcfg-$iname/DNS"
    ]
  }

}

class sysconfig::tty($nb_actives_consoles='1-2') {

  file { '/etc/sysconfig/init':
    content => template('sysconfig/init.erb'),
    owner => 'root', group => 'root', mode => '644' 
  }
} 
