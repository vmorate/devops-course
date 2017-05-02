# = Class: Jenkins 2
# This is the main jenkins 2 class
# == Parameters
#
# Specific class parameters
# [*jenkins_version*]
#   Version jenkins that will be installed.
#
# [*java_version*]
#   Java is a requite for jenkins packages.
#    This setting is a java version that will be installed
#
# == Author
#    Alex Fortes
class jenkins2(

  $jenkins_version = undef,
  $java_version = undef,
  $manage_repo = true,
  $jenkins_java_options = "-Djava.awt.headless=true",
  $jenkins_port = 8080,
  $proxy = undef,
#  $AD_name = undef,
#  $AD_server = undef,
#  $AD_site = undef,

  ) {

  if $manage_repo == true {
    yumrepo { 'jenkins':
      baseurl    => 'http://pkg.jenkins.io/redhat-stable',
      descr      => 'Jenkins-stable',
      enabled    => '1',
      gpgcheck   => '0',
    }
  }

   package { 'java':
     ensure => $java_version,
   }
   package { 'jenkins':
     ensure  => $jenkins_version ,
     require => Package['java'],
   }
   file { 'tmp_jenkins':
     ensure  => directory,
     path    => '/var/lib/jenkins/tmp',
     owner   => 'jenkins',
     group   => 'jenkins',
     require => [ Package['jenkins'], Yumrepo['jenkins'] ],
   }
   file { 'jenkins_configuration_file':
     ensure  => present,
     path    => '/etc/sysconfig/jenkins',
     content => template('jenkins2/jenkins.erb'),
     require => [ Package['jenkins'], File['tmp_jenkins'] ],
     notify  => [Service['jenkins']],
   }
   service { 'jenkins':
     enable  => true,
     ensure  => running,
     require => [ Package["java"], Package['jenkins'] ],
   }
   file { 'plugin_script':
     ensure  => file,
     source  => 'puppet:///modules/jenkins2/install_jenkins_plugin.sh',
     path    => '/var/lib/jenkins/install_jenkins_plugin.sh',
     require => Package['jenkins'],
     mode    => '0755'
   }
#   file { 'jenkins_xml_file':
#     ensure  => present,
#     path    => '/var/lib/jenkins/config.xml',
#     content => template('jenkins2/config.xml.erb'),
#     require => [ Package['jenkins'], File['tmp_jenkins'] ],
#     notify  => [Service['jenkins']],
#   }
 $plugins = hiera('jenkins2::plugin_hash')
 create_resources('jenkins2::plugin',$plugins)

 # Add user jenkins to log _written
#  exec { "adding Jenkins to log_written":
#    command => "/usr/sbin/usermod -aG log_written jenkins",
#    notify  => Service['jenkins'],
#    require => [ Group['log_written'], Package['jenkins'] ],
#    unless  => "/usr/bin/groups ${name} | grep log_written"
#  }


 service { 'firewalld':
   enable      => false,
   ensure      => stopped,
 }

}