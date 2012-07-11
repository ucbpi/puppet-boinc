class boinc::service {
  service { 'boinc-client':
      ensure  => running,
      require => Package['boinc-client'],
  }
}
