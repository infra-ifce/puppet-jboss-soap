node 'base-rhel' {
  
  include sysconfig::network_interface
  include sysconfig::tty 

  include postfix::postfix
  include ifce::profile

  include ntp::ntp_servers
  include ntp::ntpd 

  include resolv::resolv_conf

  include snmp::snmpd
}

node 'template-jboss' inherits base-rhel {

  notice("Setting host $fqdn using Puppet ($puppetversion).")
  
  $profile_name='ifce'
  $product_home='/usr/share/jboss-soap/jboss-as/'
  $profile='production'
  
#  FIXME: to finish
#  httpd::mod_cluster_client { 'mod_cluster_libs':
#    deploy_folder => "$product_home/server/$profile/deploy",
#    require => Jboss-As::Os_Tuning['soap-tuning'],
#  }
  jboss-as::os_tuning { 'soap-tuning': } 

  jboss-as::jvmRoute { "$profile_name-$fqdn":
    product_home => $product_home,
    profile => $profile_name,
  }
 
  file { "/etc/init.d/jboss-soap-$profile_name-1": 
    ensure => link,
    target => '/etc/init.d/jboss-soap',
    require => Package['jboss-soap']
  }

  service { "jboss-soap-$profile_name-1":
    ensure => running,
    enable => true,
    require => File["/etc/init.d/jboss-soap-$profile_name-1"]
  }
}

node template-frontlb inherits base-rhel { }

node template-frontws inherits base-rhel { }

node template-lamp inherits base-rhel { }

node template-nfs inherits base-rhel { }

node template-mysql inherits base-rhel { }

node template-zend inherits base-rhel { 
  zendserver6::base { 'zendserver6': }
}

node template-cups inherits base-rhel { }

node template-tomcat inherits base-rhel {
  notice("Setting host $fqdn using Puppet ($puppetversion), to host Tomcat server")

  tomcat7::setup { 'tomcat7':
  
  }
}

node /vm-jboss*/ inherits template-jboss {

  $app_java_opts='-XX:+UseConcMarkSweepGC -XX:+CMSIncrementalMode -Dsun.lang.ClassLoader.allowArraySyntax=true -XX:+UseLargePages -XX:LargePageSizeInBytes=4m'
  jboss-as::base { 'jboss-soap': 
    jvm_memory => '2048',
    proxy_list => "vm-frontlbdev.ifce.lan:6666",
  } 

}

node /vm-frontlb*/ inherits template-frontlb {
   
  httpd::base { 'httpd-setup': } 
  httpd::mod_cluster_conf { 'mod-cluster-conf': } 
}

node vm-puppet inherits template-jboss {
 
  # vm-frontlb conf
  httpd::base { 'httpd-setup': } 
  httpd::mod_cluster_conf { 'mod-cluster-conf': } 

  # vm-jboss conf
  $app_java_opts='-XX:+UseConcMarkSweepGC -XX:+CMSIncrementalMode -Dsun.lang.ClassLoader.allowArraySyntax=true -XX:+UseLargePages -XX:LargePageSizeInBytes=4m'
  jboss-as::base { 'jboss-soap': 
    jvm_memory => '1024',
  }
}

node /vm-frontws*/ inherits template-frontws { }

node /vm-lamp*/ inherits template-lamp { }

node /vm-tomcat*/ inherits template-tomcat { }

node /vm-reports*/ inherits template-tomcat { }

node /vm-restitution*/ inherits template-nfs { }

node /vm-mysql*/ inherits template-mysql { }

node /vm-zend*/ inherits template-zend { }

node /vm-editique*/ inherits template-cups { }

