#
define powerdns::config (
    $file_name     = $name,
    $user          = undef,
    $group         = undef,
    $config        = undef,
    $file_path     = undef,
    $include_dir   = undef,
    $service_name  = undef,
    $config_backup = true,
  ) {

  # Variable used in template file
  $options = $config
  $file    = "${file_path}/${file_name}"

  if $include_dir != undef {
    file { $include_dir:
      ensure => 'directory',
      mode   => '0755',
      owner  => $user,
      group  => $group,
    }
  }

  file { $file:
    path    => $file,
    content => template("${module_name}/config/KEY-VALUE-conf-file.erb"),
    mode    => '0644',
    owner   => $user,
    group   => $group,
    notify  => Service[$service_name],
    backup  => $config_backup,
  }
}
