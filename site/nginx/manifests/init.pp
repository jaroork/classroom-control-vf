# nginx/manifests/init.pp
class nginx (
  $nginx_logsdir = $nginx::params::logsdir,
  $nginx_confdir = $nginx::params::confdir,
  $nginx_blckdir = $nginx::params::blckdir,
  $nginx_pkgname = $nginx::params::pkgname,
  $nginx_fileown = $nginx::params::fileown,
  $nginx_filegrp = $nginx::params::filegrp,
  $nginx_svcname = $nginx::params::svcname,
  $nginx_docroot = $nginx::params::docroot,
) {
  
  File {
    ensure => file,
    owner  => $fileown,
    group  => $filegrp,
    mode   => '0644',
  }

  package { $pkgname:
    ensure => present,
    before => [File["${blckdir}/default.conf"],File["${confdir}/nginx.conf"]],
  }
  
  file { $docroot: 
    ensure => directory,
  }
  
  file { "${docroot}/index.html":
    source => 'puppet:///modules/nginx/index.html',
  }
  
  file { "${blckdir}/default.conf":
    content  => epp('nginx/default.conf.epp'),
  }
  
  file { "${confdir}/nginx.conf":
    content  => epp('nginx/nginx.conf.epp'),
}
    
  service { $svcname:
    ensure    => running,
    enable    => true,
    subscribe => [File["${blckdir}/default.conf"],File["${confdir}/nginx.conf"]],
  }
}
