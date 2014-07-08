node /vm-jboss*/ {
  notice("Setting host $fqdn using Puppet ($puppetversion).")
  
  $profile_name='ifce'

  $app_java_opts='-XX:+UseConcMarkSweepGC -XX:+CMSIncrementalMode -Dsun.lang.ClassLoader.allowArraySyntax=true -XX:+UseLargePages -XX:LargePageSizeInBytes=4m'
  jboss-as::base { 'jboss-soap': 
    jvm_memory => '1024',
  } 
# conf ifce-tek
  jboss-as::os_tuning { 'soap-tuning': }

}
