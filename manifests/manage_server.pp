define iis::manage_server($filter, $name, $value) {

    exec { "WebConfiguration-manage-${filter}-${name}" :
      command   => "Import-Module WebAdministration; Set-WebConfigurationProperty -Filter ${filter} -Name ${name} -Value ${value}",
      onlyif    => "Import-Module WebAdministration; if((Get-WebConfigurationProperty -Filter ${filter} -Name ${name} ).value -eq (${value}) ) { exit 1 } else { exit 0 }",
      logoutput => true,
      provider  => powershell
    }
}

