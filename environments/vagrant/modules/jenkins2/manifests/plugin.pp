# Define: jenkins2:plugin
#
# This is the class that allow install plugin in a jenkins.
#
define jenkins2::plugin () {
  exec { "install_plugin_${title}":
    command  => "/var/lib/jenkins/install_jenkins_plugin.sh ${title}",
    path     => '/usr/bin:/usr/sbin:/bin:/usr/local/bin',
    user     => 'jenkins',
    notify   => Service['jenkins'],
  }
}

