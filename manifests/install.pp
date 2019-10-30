# @summary A short summary of the purpose of this class
#
# A description of what this class does
#
# @example
#   include es_lite::install
class es_lite::install {
  case $::es_lite::install_method {
    'package': {
      ensure_packages('wget')
      exec { 'import-elasticsearch-7.x-key':
        path      => '/bin:/usr/bin:/sbin:/usr/sbin',
        command   => 'rpm --import https://artifacts.elastic.co/GPG-KEY-elasticsearch',
        logoutput => 'on_failure',
        unless    => "rpm -q gpg-pubkey-$(echo $(wget -q https://artifacts.elastic.co/GPG-KEY-elasticsearch -O - | gpg -q --throw-keyids --keyid-format short | grep pub | cut -f2 -d/ | cut -f1 -d' ' | tr '[A-Z]' '[a-z]'))"
      }
      -> yumrepo { 'elasticsearch':
        name     => 'elasticsearch-7.x',
        descr    => 'Elasticsearch repository for 7.x packages',
        baseurl  => 'https://artifacts.elastic.co/packages/7.x/yum',
        gpgcheck => 1,
        gpgkey   => 'https://artifacts.elastic.co/GPG-KEY-elasticsearch',
        enabled  => 1,
      }
      -> package { 'elasticsearch':
        ensure => $es_lite::version,
      }
    }
    default: {
      fail "Unsupported install method: ${::es_lite::install_method}"
    }
  }
}
