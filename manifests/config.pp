# == Class: boinc::config
#
# Contains some module configuration information, and is not intended for
# direct use
#
class boinc::config {
    # we need these before some of the main packages will work
    $pre_pkgs = [ 'epel-release' ]

    $pkgs = [ 'compat-libstdc++-296.i686',
              'compat-libstdc++-33.i686',
              'compat-libstdc++-33.x86_64',
              'boinc-client', ]

}
