define jboss-as::base($product_name='jboss-soap', $product_home='/usr/share/jboss-soap/jboss-as/', $profile='production', $jvm_memory='4096', $proxy_list="$fqdn:6666") {

  $perm_size='1024'
  $user='jboss'
  $group=$user
  $java_library_path="$product_home/jboss-ep-5.2/native/lib64"
  $jboss_user='admin'
  $jboss_user_password='admin'
  
  package { $product_name:
    ensure => installed,
  }

  file { '/usr/share/jboss-soap/jboss-as/server/production/log':
    ensure => directory,
    owner => $user,
    group => $group,
    require =>  Package[$product_name]
  }

  file { "$product_home/server/$profile/run.conf":
    content => template("jboss-as/run.conf.erb"),
    owner => $user,
    group => $group,
    require => Package[$product_name],
  }

  file { "$product_home/server/$profile/conf/props/soa-users.properties":
    content => template("jboss-as/soa-users.properties.erb"),
    owner => $user,
    group => $group,
    require => Package[$product_name],
  }

  file { "$product_home/server/$profile_name":
    ensure => link,
    target => "$product_home/server/$profile",
    require => Package[$product_name]
  }
}

define jboss-as::os_tuning($kernel_shmmax='8589934592', $kernel_shmall='1572864', $vm_hugetlb_shm_group='500', $vm_nr_hugepages='3072', $domain_value='jboss', $limit_value='6291456') {
  sysctl { 'kernel.shmmax': value => $kernel_shmmax }
  sysctl { 'kernel.shmall': value => $kernel_shmall }
  sysctl { 'vm.hugetlb_shm_group': value => $vm_hugetlb_shm_group }
  sysctl { 'vm.nr_hugepages': value => $vm_nr_hugepages }

  file { "/etc/security/limits.conf":
    content => template("jboss-as/limits.conf.erb"),
    owner => 'root',
    group => 'root',
    mode => 644
  }
}

define jboss-as::jvmRoute($jvmRoute=$name, $product_home, $profile, $user='jboss', $group='jboss', $product_name='jboss-soap') {
  
  file { "$product_home/server/$profile/deploy/jbossweb.sar/server.xml":
    content => template("jboss-as/server.xml.erb"),
    owner => $user,
    group => $group,
    require => Package[$product_name],
  }
}
