define iis::manage_site_header(
  $site_name = 'Default Web Site',
  $header_name = $title,
  $header_value
){
   exec { "create-site-header-${name}":
     command   => template('iis/create_header.ps1.erb'),
     onlyif    => template('iis/exists_header.ps1.erb'),
     provider  => powershell,
     logoutput => true,
   }

   exec { "update-site-header-${name}":
     command   => template('iis/update_header.ps1.erb'),
     onlyif    => template('iis/uptodate_header.ps1.erb'),
     provider  => powershell,
     logoutput => true,
     require   => exec["create-site-header-${name}"]
  }
}
