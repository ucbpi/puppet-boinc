# == Class: boinc
#
# Installs, configures and manages BOINC
#
# === Parameters:
# [*acct_mgr_url*]
#   The account manager URL to attach this BOINC client to
#
# [*username*]
#   Account manager username
#
# [*password*]
#   Account manager password
#
class boinc (
  $acct_mgr_url,
  $username,
  $password,
) {
  include boinc::install, boinc::service
}
