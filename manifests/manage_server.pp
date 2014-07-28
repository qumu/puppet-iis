define iis::manage_server($filter, $name, $value) {
  include 'iis::param::powershell'

    exec { "WebConfiguration-manage-${filter}-${name}" :
      command   => "${iis::param::powershell::command} -Command \"Import-Module WebAdministration; Set-WebConfigurationProperty -Filter ${filter} -Name ${name} -Value ${value} \"",
      path      => "${iis::param::powershell::path};${::path}",
      onlyif    => "${iis::param::powershell::command} -Command \"Import-Module WebAdministration; if((Get-WebConfigurationProperty -Filter ${filter} -Name ${name} ).value -eq (${value}) ) { exit 1 } else { exit 0 }\"",
      logoutput => true,
    }
}

