class boinc::install {
    require boinc::config

    stage { 'boinc-pre-install': before => Stage['boinc-install']}
    stage { 'boinc-post-install': require => Stage['boinc-install'] }
    stage { 'boinc-install': require => Stage['boinc-pre-install'] }
    
    class { 'boinc::pre-install': stage => boinc-pre-install }
    class { 'boinc::post-install': stage => boinc-post-install }
    class { 'boinc::client-install': stage => boinc-install }
}

class boinc::pre-install {
   package { $boinc::config::pre_pkgs:
       ensure => installed,
   } 
}

class boinc::client-install {
  package { $boinc::config::pkgs:
      ensure => installed,
  }
}

class boinc::post-install {
  exec { "join_acct_mgr_${boinc::acct_mgr_url}":
      environment => [ "BOINC_USERNAME=$boinc::username", 
                       "BOINC_PASSWORD=$boinc::password", 
                       "BOINC_ACCT_MGR_URL=$boinc::acct_mgr_url" ],
      cwd => '/var/lib/boinc/',
      command => "boinccmd --join_acct_mgr \$BOINC_ACCT_MGR_URL \$BOINC_USERNAME \$BOINC_PASSWORD",
      path => '/usr/bin/',
      returns => [ '0', '126' ]
    }
} 
