class ssh::sshd_config($use_dns='yes') {

  file { '/etc/ssh/sshd_config':
    content => template('ssh/sshd_config.erb'),
    notify => Service['sshd'],
  }
}
