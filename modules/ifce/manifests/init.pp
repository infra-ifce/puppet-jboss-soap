class ifce::profile {
  
  file { '/etc/profile.d/ifce.sh':
    source => 'puppet:///modules/ifce/ifce.sh',
    mode => 744, owner => 'root', group => 'root',
  }

}
