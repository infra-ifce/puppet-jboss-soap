class ntp::ntp_servers {

   host { 'ntp1':
      host_aliases => ['ntp1.ifce.lan', 'ntp1.intranet.haras-nationaux.fr'],
      ip => '10.211.162.11',
    }
  
    host { 'ntp2':
      host_aliases => ['ntp2.ifce.lan', 'ntp2.intranet.haras-nationaux.fr'],
      ip => '10.211.162.168',
    }

}

class ntp::ntpd {

  $product_name='ntp'

  package { $product_name: 
    ensure => installed,
  }

  file { '/etc/ntp.conf':
      source => 'puppet:///modules/ntp/ntp.conf',
      mode => 644, owner => 'root', group => 'root',
      notify => Service['ntpd'],
  }
  
  service { 'ntpd':
      ensure => running,
      enable => true,
      require => File['/etc/ntp.conf']
  }

}
