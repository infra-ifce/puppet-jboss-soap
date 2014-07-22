define httpd::base($jboss_server_xml, $user='jboss', $group='jboss') {

  $httpd_mod_cluster_packages=['']
  package { $httpd_mod_cluster_packages:
    ensure => installed,
  }

  service { 'httpd':
    enable => true,
    ensure => running,
    require => Package[$httpd_mod_cluster_packages]
  }
}

define httpd::mod_cluster($jboss_server_xml, $user='jboss', $group='jboss') {

  file { $jboss_server_xml:
    content => template("httpd/server.xml.erb"),
    owner => $user,
    group => $group
  }
}


