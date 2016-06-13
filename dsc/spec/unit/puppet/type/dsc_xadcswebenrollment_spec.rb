#!/usr/bin/env ruby
require 'spec_helper'

describe Puppet::Type.type(:dsc_xadcswebenrollment) do

  let :dsc_xadcswebenrollment do
    Puppet::Type.type(:dsc_xadcswebenrollment).new(
      :name     => 'foo',
      :dsc_name => 'foo',
    )
  end

  it "should stringify normally" do
    expect(dsc_xadcswebenrollment.to_s).to eq("Dsc_xadcswebenrollment[foo]")
  end

  it 'should default to ensure => present' do
    expect(dsc_xadcswebenrollment[:ensure]).to eq :present
  end

  it 'should not accept array for dsc_caconfig' do
    expect{dsc_xadcswebenrollment[:dsc_caconfig] = ["foo", "bar", "spec"]}.to raise_error(Puppet::ResourceError)
  end

  it 'should not accept boolean for dsc_caconfig' do
    expect{dsc_xadcswebenrollment[:dsc_caconfig] = true}.to raise_error(Puppet::ResourceError)
  end

  it 'should not accept int for dsc_caconfig' do
    expect{dsc_xadcswebenrollment[:dsc_caconfig] = -16}.to raise_error(Puppet::ResourceError)
  end

  it 'should not accept uint for dsc_caconfig' do
    expect{dsc_xadcswebenrollment[:dsc_caconfig] = 16}.to raise_error(Puppet::ResourceError)
  end

  it "should not accept empty password for dsc_credential" do
    expect{dsc_xadcswebenrollment[:dsc_credential] = {"user"=>"user", "password"=>""}}.to raise_error(Puppet::ResourceError)
  end

  it 'should not accept array for dsc_credential' do
    expect{dsc_xadcswebenrollment[:dsc_credential] = ["foo", "bar", "spec"]}.to raise_error(Puppet::ResourceError)
  end

  it 'should not accept boolean for dsc_credential' do
    expect{dsc_xadcswebenrollment[:dsc_credential] = true}.to raise_error(Puppet::ResourceError)
  end

  it 'should not accept int for dsc_credential' do
    expect{dsc_xadcswebenrollment[:dsc_credential] = -16}.to raise_error(Puppet::ResourceError)
  end

  it 'should not accept uint for dsc_credential' do
    expect{dsc_xadcswebenrollment[:dsc_credential] = 16}.to raise_error(Puppet::ResourceError)
  end

  it 'should accept dsc_ensure predefined value Present' do
    dsc_xadcswebenrollment[:dsc_ensure] = 'Present'
    expect(dsc_xadcswebenrollment[:dsc_ensure]).to eq('Present')
  end

  it 'should accept dsc_ensure predefined value present' do
    dsc_xadcswebenrollment[:dsc_ensure] = 'present'
    expect(dsc_xadcswebenrollment[:dsc_ensure]).to eq('present')
  end

  it 'should accept dsc_ensure predefined value present and update ensure with this value (ensure end value should be a symbol)' do
    dsc_xadcswebenrollment[:dsc_ensure] = 'present'
    expect(dsc_xadcswebenrollment[:ensure]).to eq(dsc_xadcswebenrollment[:dsc_ensure].downcase.to_sym)
  end

  it 'should accept dsc_ensure predefined value Absent' do
    dsc_xadcswebenrollment[:dsc_ensure] = 'Absent'
    expect(dsc_xadcswebenrollment[:dsc_ensure]).to eq('Absent')
  end

  it 'should accept dsc_ensure predefined value absent' do
    dsc_xadcswebenrollment[:dsc_ensure] = 'absent'
    expect(dsc_xadcswebenrollment[:dsc_ensure]).to eq('absent')
  end

  it 'should accept dsc_ensure predefined value absent and update ensure with this value (ensure end value should be a symbol)' do
    dsc_xadcswebenrollment[:dsc_ensure] = 'absent'
    expect(dsc_xadcswebenrollment[:ensure]).to eq(dsc_xadcswebenrollment[:dsc_ensure].downcase.to_sym)
  end

  it 'should not accept values not equal to predefined values' do
    expect{dsc_xadcswebenrollment[:dsc_ensure] = 'invalid value'}.to raise_error(Puppet::ResourceError)
  end

  it 'should not accept array for dsc_ensure' do
    expect{dsc_xadcswebenrollment[:dsc_ensure] = ["foo", "bar", "spec"]}.to raise_error(Puppet::ResourceError)
  end

  it 'should not accept boolean for dsc_ensure' do
    expect{dsc_xadcswebenrollment[:dsc_ensure] = true}.to raise_error(Puppet::ResourceError)
  end

  it 'should not accept int for dsc_ensure' do
    expect{dsc_xadcswebenrollment[:dsc_ensure] = -16}.to raise_error(Puppet::ResourceError)
  end

  it 'should not accept uint for dsc_ensure' do
    expect{dsc_xadcswebenrollment[:dsc_ensure] = 16}.to raise_error(Puppet::ResourceError)
  end

  it 'should require that dsc_name is specified' do
    #dsc_xadcswebenrollment[:dsc_name]
    expect { Puppet::Type.type(:dsc_xadcswebenrollment).new(
      :name     => 'foo',
      :dsc_caconfig => 'foo',
      :dsc_credential => {"user"=>"user", "password"=>"password"},
      :dsc_ensure => 'Present',
    )}.to raise_error(Puppet::Error, /dsc_name is a required attribute/)
  end

  it 'should not accept array for dsc_name' do
    expect{dsc_xadcswebenrollment[:dsc_name] = ["foo", "bar", "spec"]}.to raise_error(Puppet::ResourceError)
  end

  it 'should not accept boolean for dsc_name' do
    expect{dsc_xadcswebenrollment[:dsc_name] = true}.to raise_error(Puppet::ResourceError)
  end

  it 'should not accept int for dsc_name' do
    expect{dsc_xadcswebenrollment[:dsc_name] = -16}.to raise_error(Puppet::ResourceError)
  end

  it 'should not accept uint for dsc_name' do
    expect{dsc_xadcswebenrollment[:dsc_name] = 16}.to raise_error(Puppet::ResourceError)
  end

  # Configuration PROVIDER TESTS

  describe "powershell provider tests" do

    it "should successfully instanciate the provider" do
      described_class.provider(:powershell).new(dsc_xadcswebenrollment)
    end

    before(:each) do
      @provider = described_class.provider(:powershell).new(dsc_xadcswebenrollment)
    end

    describe "when dscmeta_module_name existing/is defined " do

      it "should compute powershell dsc test script with Invoke-DscResource" do
        expect(@provider.ps_script_content('test')).to match(/Invoke-DscResource/)
      end

      it "should compute powershell dsc test script with method Test" do
        expect(@provider.ps_script_content('test')).to match(/Method\s+=\s*'test'/)
      end

      it "should compute powershell dsc set script with Invoke-DscResource" do
        expect(@provider.ps_script_content('set')).to match(/Invoke-DscResource/)
      end

      it "should compute powershell dsc test script with method Set" do
        expect(@provider.ps_script_content('set')).to match(/Method\s+=\s*'set'/)
      end

    end

    describe "when dsc_ensure is 'present'" do

      before(:each) do
        dsc_xadcswebenrollment.original_parameters[:dsc_ensure] = 'present'
        dsc_xadcswebenrollment[:dsc_ensure] = 'present'
        @provider = described_class.provider(:powershell).new(dsc_xadcswebenrollment)
      end

      it "should update :ensure to :present" do
        expect(dsc_xadcswebenrollment[:ensure]).to eq(:present)
      end

      it "should compute powershell dsc test script in which ensure value is 'present'" do
        expect(@provider.ps_script_content('test')).to match(/ensure = 'present'/)
      end

      it "should compute powershell dsc set script in which ensure value is 'present'" do
        expect(@provider.ps_script_content('set')).to match(/ensure = 'present'/)
      end

    end

    describe "when dsc_ensure is 'absent'" do

      before(:each) do
        dsc_xadcswebenrollment.original_parameters[:dsc_ensure] = 'absent'
        dsc_xadcswebenrollment[:dsc_ensure] = 'absent'
        @provider = described_class.provider(:powershell).new(dsc_xadcswebenrollment)
      end

      it "should update :ensure to :absent" do
        expect(dsc_xadcswebenrollment[:ensure]).to eq(:absent)
      end

      it "should compute powershell dsc test script in which ensure value is 'present'" do
        expect(@provider.ps_script_content('test')).to match(/ensure = 'present'/)
      end

      it "should compute powershell dsc set script in which ensure value is 'absent'" do
        expect(@provider.ps_script_content('set')).to match(/ensure = 'absent'/)
      end

    end

    describe "when dsc_resource has credentials" do

      it "should convert credential hash to a pscredential object" do
        expect(@provider.ps_script_content('test')).to match(/| new-pscredential'/)
      end

    end


  end
end
