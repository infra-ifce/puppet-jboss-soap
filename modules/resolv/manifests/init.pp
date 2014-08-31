class resolv::resolv_conf {

 file { '/etc/resolv.conf':
   source => 'puppet:///modules/resolv/resolv.conf',
   mode => 644, owner => 'root', group => 'root',
 }
 # TODO: associated this to a "before stage"
}
