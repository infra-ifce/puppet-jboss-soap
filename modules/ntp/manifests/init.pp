class ntp::ifce_ntp_defs {

   host { 'ntp1':
      host_aliases => ['ntp1.intranet.haras-nationaux.fr','ntp1.ifce.lan'],
      ip => '10.211.162.11',
    }
  
    host { 'ntp2':
      host_aliases => ['ntp2.ifce.lan', 'ntp2.intranet.haras-nationaux.fr'],
      ip => '10.211.162.168',
    }

}
