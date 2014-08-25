define tomcat7::setup($catalina_base='/usr/share/tomcat7', $packages=[ 'java-1.7.0-openjdk', 'tomcat7']) {

  package { $packages:
    ensure => installed,
  }
  
  file { '/usr/sbin/tomcat7':
    content => template("tomcat7/tomcat7.erb"),
    mode => 744,
    require => Package[$packages],
  }  

  
}
