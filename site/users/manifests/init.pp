class users {
  user {'fundamentals':
  ensure => present,
  }
}

node default {
  include users,
}
