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
  -> class { '::es_lite::config': }
  ~> class { '::es_lite::service': }
}
