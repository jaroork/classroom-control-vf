class skeleton {
  file { '/etc/skel':
    ensure => 'directory',
    group  => '0',
    mode   => '0755',
    owner  => '0',
  }
file { '/etc/skel/.bashrc':
  ensure  => 'file',
  group   => 'root',
  mode    => '0664',
  owner   => 'root',
  source  => 'puppet:///modules/skeleton/bashrc',
}
