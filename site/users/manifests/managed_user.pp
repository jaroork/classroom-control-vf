define users::managed_user ( 
  $group = $title,
) {
  user { $title:
    ensure => present,
  }
  file { "/home/${title}":
    ensure => directory,
    owner => $title,
    group => $group,
  }
  file { "/home/${title}/.ssh":
    ensure => directory,
    owner => $title,
    mode => '0700',
  }
  file { "/home/${title}/.bashrc":
    ensure => file,
    owner => $title,
    mode => '0644',
    source => 'puppet:///modules/users/bashrc',
  }
}
