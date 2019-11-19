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
      exec { 'import-elasticsearch-key':
        path      => '/bin:/usr/bin:/sbin:/usr/sbin',
        command   => 'rpm --import https://artifacts.elastic.co/GPG-KEY-elasticsearch',
        logoutput => 'on_failure',
        unless    => "rpm -q gpg-pubkey-$(echo $(wget -q https://artifacts.elastic.co/GPG-KEY-elasticsearch -O - | gpg -q --throw-keyids --keyid-format short | grep pub | cut -f2 -d/ | cut -f1 -d' ' | tr '[A-Z]' '[a-z]'))"
      }
      if ($::es_lite::version =~ /^([0-9]+)\.[0-9]+\.[0-9]+$/) {
        $major_version = $1
      } else {
        $major_version = 7
      }
      yumrepo { 'elasticsearch':
        name     => "elasticsearch-${major_version}.x",
        descr    => "Elasticsearch repository for ${major_version}.x packages",
        baseurl  => "https://artifacts.elastic.co/packages/${major_version}.x/yum",
        gpgcheck => 1,
        gpgkey   => 'https://artifacts.elastic.co/GPG-KEY-elasticsearch',
        enabled  => 1,
        require  => Exec['import-elasticsearch-key'],
      }
      package { 'elasticsearch':
        ensure  => $es_lite::version,
        require => Yumrepo['elasticsearch'],
      }
    }
    default: {
      fail "Unsupported install method: ${::es_lite::install_method}"
    }
  }
}
