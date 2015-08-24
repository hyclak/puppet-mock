# == Class: mock
#
# See README.md for more details.
#
class mock (
  $ensure = 'present',
  $manage_group = true,
  $group_gid = '135',
  $group_name = $mock::params::group_name,
  $package_name = $mock::params::package_name,
  $epel_repo_name = 'epel',
) inherits mock::params {

  validate_re($ensure, [ '^present', '^absent' ])
  validate_bool($manage_group)

  if $manage_group {
    group { 'mock':
      ensure  => $ensure,
      name    => $group_name,
      gid     => $group_gid,
      before  => Package['mock'],
    }
  }

  package { 'mock':
    ensure  => $ensure,
    name    => $package_name,
    require => Yumrepo[$epel_repo_name],
  }

}
