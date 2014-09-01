class snmp::snmpd {

  package { 'net-snmp': ensure => installed, }
  
  file { '/etc/snmp': 
    ensure => directory,
    require => Package['net-snmp'],
  }
  
  file { '/etc/snmp/snmpd.conf':
    source => 'puppet:///modules/snmp/snmpd.conf',
    mode => '644', owner => 'root', group => 'root',
    notify => Service['snmpd'],
    require => File['/etc/snmp'],
  }
  
  service { 'snmpd':
    ensure => running,
    enable => true,
    require => File['/etc/snmp/snmpd.conf'],
  }
}
