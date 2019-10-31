# @summary A short summary of the purpose of this class
#
# A description of what this class does
#
# @example
#   include es_lite::service
class es_lite::service {
  $ensure = $es_lite::manage_service ? {
    true  => 'running',
    false => undef,
  }
  service { 'elasticsearch':
    ensure => $ensure,
    enable => true,
  }
}
