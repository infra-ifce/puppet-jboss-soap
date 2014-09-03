define zendserver6::base($zendserver_packages=['zend-server-php-5.4','php-5.4-java-bridge-zend-server'], $zendserver_service_name='zend-server') {

  package {$zendserver_packages:
    ensure => install
  }
  
  service {$zendserver_service_name:
    enable => true,
    ensure => running,
    require => $zendserver_packages
  }

}

define zendserver6::changeframework($zendserver_packages='zend-server-php-5.4', $zendserver_service_name='zend-server', $zendserver_framework_rpm='zend-server-framework-1.12.3', $zendserver_home='/usr/local/zend'){
  
  package {$zendserver_framework_rpm:
    ensure => install,
    require => Package[$zendserver_packages]
  }
  
  file {"$zendserver_home/share/ZendFramework":
    ensure => 'link',
    target => "$zendserver_home/share/ZendFramework-1.12.3/",
    require => Package[$zendserver_framework_rpm]
  }
}
