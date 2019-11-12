# @summary A short summary of the purpose of this class
#
# A description of what this class does
#
# @example
#   include es_lite::service
class es_lite::service {
  include systemd::systemctl::daemon_reload

  systemd::dropin_file { 'elasticsearch.conf':
    unit   => 'elasticsearch.service',
    source => 'puppet:///modules/es_lite/systemd-service-override.conf',
  }

  Class['systemd::systemctl::daemon_reload']->Service['elasticsearch']

  $ensure = $es_lite::manage_service ? {
    true  => 'running',
    false => undef,
  }
  service { 'elasticsearch':
    ensure => $ensure,
    enable => true,
  }
}
