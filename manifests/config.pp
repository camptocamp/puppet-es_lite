# @summary A short summary of the purpose of this class
#
# A description of what this class does
#
# @example
#   include es_lite::config
class es_lite::config {
  file { '/etc/elasticsearch/elasticsearch.yml':
    ensure  => file,
    owner   => 'root',
    group   => 'elasticsearch',
    mode    => '0660',
    content => $es_lite::config_content,
  }
}
