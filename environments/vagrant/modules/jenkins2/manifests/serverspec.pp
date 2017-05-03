# Define: jenkins2:servespec
#
# This is the class that allow install ruby and serverspec.
#
class jenkins2::serverspec(
  $version = '2.0.0.648-29.el7',
  ) {

  package { 'ruby':
    ensure  => $version,
  }->
  package { 'serverspec':
      ensure   => 'installed',
      provider => 'gem',
      install_options => ['--http-proxy', "${jenkins2::proxy}"],
  }
}
