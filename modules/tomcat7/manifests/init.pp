define tomcat7::setup($catalina_base='/usr/share/tomcat7', $packages=[ 'java-1.7.0-openjdk', 'tomcat7', 'tomcat7-admin-webapps', 'tomcat7-log4j', 'tomcat-native']) {

  package { $packages:
    ensure => installed,
  }

    service { 'tomcat7':
      ensure => running,
      enable => true,
      require => [ File['/etc/tomcat7/tomcat7.conf'], Package['tomcat7'] ]
    }
  
  file { '/usr/sbin/tomcat7':
    content => template("tomcat7/tomcat7.erb"),
    mode => 755,
    require => Package[$packages],
  }  

  
}
