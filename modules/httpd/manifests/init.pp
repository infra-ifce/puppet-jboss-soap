define httpd::base($httpd_mod_cluster_packages=['httpd','mod_cluster-tomcat7'], $httpd_service_name='httpd') {

  package { $httpd_mod_cluster_packages:
    ensure => installed,
  }

  service { $httpd_service_name:
    enable => true,
    ensure => running,
  }
}

define httpd::mod_cluster_conf($httpd_conf='/etc/httpd/conf.d', $modcluster_cache='/var/cache/mod_cluster', $modcluster_port='6666', $modcluster_bind_address='*', $httpd_mod_cluster_packages=['httpd'], $httpd_service_name='httpd') {

  file { "$httpd_conf/mod_cluster.conf":
    content => template("httpd/mod_cluster.conf.erb"),
    owner => 'root', group => 'root',
    require => Package[$httpd_mod_cluster_packages],
    notify => Service[$httpd_service_name]
  }
}
