require 'pathname'

Puppet::Type.newtype(:dsc_choclatey) do
  require Pathname.new(__FILE__).dirname + '../../' + 'puppet/type/base_dsc'
  require Pathname.new(__FILE__).dirname + '../../puppet_x/puppetlabs/dsc_type_helpers'


  @doc = %q{
    The DSC Choclatey resource type.
    Automatically generated from
    'Choclatey/DSCResources/Choclatey/Choclatey.schema.mof'

    To learn more about PowerShell Desired State Configuration, please
    visit https://technet.microsoft.com/en-us/library/dn249912.aspx.

    For more information about built-in DSC Resources, please visit
    https://technet.microsoft.com/en-us/library/dn249921.aspx.

    For more information about xDsc Resources, please visit
    https://github.com/PowerShell/DscResources.
  }

  validate do
      fail('dsc_installdir is a required attribute') if self[:dsc_installdir].nil?
    end

  def dscmeta_resource_friendly_name; 'Choclatey' end
  def dscmeta_resource_name; 'Choclatey' end
  def dscmeta_module_name; 'Choclatey' end
  def dscmeta_module_version; '1.0' end

  newparam(:name, :namevar => true ) do
  end

  ensurable do
    newvalue(:exists?) { provider.exists? }
    newvalue(:present) { provider.create }
    defaultto { :present }
  end

  # Name:         InstallDir
  # Type:         string
  # IsMandatory:  True
  # Values:       None
  newparam(:dsc_installdir) do
    def mof_type; 'string' end
    def mof_is_embedded?; false end
    desc "InstallDir"
    isrequired
    validate do |value|
      unless value.kind_of?(String)
        fail("Invalid value '#{value}'. Should be a string")
      end
    end
  end

  # Name:         ChocoInstallScriptUrl
  # Type:         string
  # IsMandatory:  False
  # Values:       None
  newparam(:dsc_chocoinstallscripturl) do
    def mof_type; 'string' end
    def mof_is_embedded?; false end
    desc "ChocoInstallScriptUrl"
    validate do |value|
      unless value.kind_of?(String)
        fail("Invalid value '#{value}'. Should be a string")
      end
    end
  end


  def builddepends
    pending_relations = super()
    PuppetX::Dsc::TypeHelpers.ensure_reboot_relationship(self, pending_relations)
  end
end

Puppet::Type.type(:dsc_choclatey).provide :powershell, :parent => Puppet::Type.type(:base_dsc).provider(:powershell) do
  confine :true => (Gem::Version.new(Facter.value(:powershell_version)) >= Gem::Version.new('5.0.10240.16384'))
  defaultfor :operatingsystem => :windows

  mk_resource_methods
end
