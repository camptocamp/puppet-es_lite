# @summary A short summary of the purpose of this class
#
# A description of what this class does
#
# @example
#   include es_lite
class es_lite(
  String[1]                 $version        = 'present',
  Variant[String[1], Undef] $config_content = undef,
  Enum['package', 'podman'] $install_method = 'package',
  Boolean                   $manage_service = false,
) {
  class { '::es_lite::install': }

  $notify = $es_lite::manage_service ? {
      true  => Class['::es_lite::service'],
      false => undef,
    }
  class { '::es_lite::config':
    require => Class['::es_lite::install'],
    notify  => $notify,
  }

  class { '::es_lite::service':
    require => Class['::es_lite::config'],
  }
}
