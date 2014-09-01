class postfix::postfix () {

    package { 'postfix': ensure => installed, }
  
    service { 'postfix':
      ensure => running,
      enable => true,
      require => [ File['/etc/postfix/main.cf'], Package['postfix'], File['/etc/aliases'] ]
    }
  
    $relayhost_domain='smtp.ifce.lan'  
    file { '/etc/postfix/main.cf':
      content => template("postfix/main.cf.erb"),
      notify => Service['postfix'],
    }

    $exploit_alias='support-exploitation@ifce.fr'
    file { '/etc/aliases':
      content => template("postfix/aliases.erb"),
      notify => [ Service['postfix'], Exec['/usr/bin/newaliases'] ]
    }

    exec { '/usr/bin/newaliases':  refreshonly => true }
}
