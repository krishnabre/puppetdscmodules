class prerequisitepowershell (
 $a="C:\\demo.txt",)
{
exec { 'test':
      command =>  'cmd.exe /c  choco install notepadplusplus -y',
      path    => ['C:\WINDOWS\System32','C:\ProgramData\chocolatey\bin','C:\ProgramData\chocolatey\choco.exe'],
      logoutput => true,
      creates   => 'C:\demo.txt',
      
      
    }

if "test -f ${a}"
{
 file {'C:\ne.txt':
      ensure => present,
}
 
}

}
