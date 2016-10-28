class nginx::params (
  $root = undef,
) {
  case $::osfamily {
    'RedHat','Debian': {
      $default_docroot = '/var/www'
      $logsdir = '/var/log/nginx'
      $confdir = '/etc/nginx'
      $blckdir = '/etc/nginx/conf.d'
      $pkgname = 'nginx'
      $fileown = 'root'
      $filegrp = 'root'
      $svcname = 'nginx'
    }
    'windows': {
      $default_docroot = 'C:/ProgramData/nginx/html'
      $logsdir = 'C:/ProgramData/nginx/logs'
      $confdir = 'C:/ProgramData/nginx'
      $blckdir = 'C:/ProgramData/nginx/conf.d'
      $pkgname = 'nginx-service'
      $fileown = 'Administrator'
      $filegrp = 'Administrators'
      $svcname = 'nginx'
    }
  }
 
  $svcuser = $::osfamily ? {
    'RedHat'  => 'nginx',
    'Debian'  => 'www-data',
    'windows' => 'nobody',
  }
  
  $docroot = $root ? {
    undef => $default_docroot,
    default => $root,
  }
}
