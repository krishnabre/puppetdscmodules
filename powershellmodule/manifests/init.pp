class powershellmodule {

file { 'directory_structure':
    ensure => 'directory',
    path   => 'C:\ProgramData\PuppetLabs\puppet\etc\modules',
    before => File["filecreation"],
  }

file {'filecreation':
    ensure      => 'directory',
    path        => 'C:\ProgramData\PuppetLabs\puppet\etc\modules\powershell',
    recurse     => 'true',
     source_permissions => ignore,
    source      => 'puppet:///modules/powershellmodule/powershell',
    require     => File["directory_structure"],

  }
}
