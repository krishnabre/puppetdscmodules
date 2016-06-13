class prerequisites {
file {'filecreation':
    ensure          => 'file',
    path           => 'E:\chocins.ps1',
    mode           => '0777',
    recurse       => 'true',

    source      => 'puppet:///modules/prerequisites/prerequisites.ps1',
    before      => Exec["chocinstall"],

  }~>


 exec { "chocinstall":

    command   =>  'C:\Windows\System32\WindowsPowerShell\v1.0\powershell.exe -executionpolicy remotesigned -file E:\chocins.ps1',
    #provider  => powershell,
   # cwd       => "E:",
 #   path      =>  ["C:\WINDOWS\System32","C:\WINDOWS\System32\WindowsPowerShell"],
  #  onlyif    => "c:\\temp\\inspect-${name}.ps1",
    logoutput => true,
  #  require   => [ File["inspect-${name}-certificate.ps1"], File["import-${name}-certificate.ps1"] ],
     require   => File["filecreation"],
  }

}
