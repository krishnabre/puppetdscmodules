class asp{



dsc_windowsfeature {'ASP': 
    
      dsc_ensure => present,
      dsc_name => Web-Asp-Net45,
    } 
}      
