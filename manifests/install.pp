class boinc::install {
    require boinc::config

    stage { "boinc-pre-install": before => Stage["main"]}
    stage { "boinc-post-install": require => Stage["main"] }

    class { "boinc::install-pre": stage => boinc-pre-install }
    class { "boinc::install-post": stage => boinc-post-install }
}

class boinc::install-pre {
   package { $boinc::config::pre_pkgs:
       ensure => installed,
   } 
}

class boinc::install-client {
  package { $boinc::config::pkgs:
      ensure => installed,
  }
}

class boinc::install-post {
  exec { "join_acct_mgr_${boinc::acct_mgr_url}":
      environment => [ "BOINC_USERNAME=$boinc::username", 
                       "BOINC_PASSWORD=$boinc::password", 
                       "BOINC_ACCT_MGR_URL=$boinc::acct_mgr_url" ],
      cwd => "/var/lib/boinc",
      command => "boinccmd --join_acct_mgr \$BOINC_ACCT_MGR_URL \$BOINC_USERNAME \$BOINC_PASSWORD",
      path => "/usr/bin/",
      returns => [ "0", "126" ]
    }
} 
