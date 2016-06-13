#!/usr/bin/env ruby
require 'spec_helper'

describe Puppet::Type.type(:dsc_choclatey) do

  let :dsc_choclatey do
    Puppet::Type.type(:dsc_choclatey).new(
      :name     => 'foo',
      :dsc_installdir => 'foo',
    )
  end

  it 'should allow all properties to be specified' do
    expect { Puppet::Type.type(:dsc_choclatey).new(
      :name     => 'foo',
      :dsc_installdir => 'foo',
      :dsc_chocoinstallscripturl => 'foo',
    )}.to_not raise_error
  end

  it "should stringify normally" do
    expect(dsc_choclatey.to_s).to eq("Dsc_choclatey[foo]")
  end

  it 'should require that dsc_installdir is specified' do
    #dsc_choclatey[:dsc_installdir]
    expect { Puppet::Type.type(:dsc_choclatey).new(
      :name     => 'foo',
    )}.to raise_error(Puppet::Error, /dsc_installdir is a required attribute/)
  end

  it 'should not accept array for dsc_installdir' do
    expect{dsc_choclatey[:dsc_installdir] = ["foo", "bar", "spec"]}.to raise_error(Puppet::ResourceError)
  end

  it 'should not accept boolean for dsc_installdir' do
    expect{dsc_choclatey[:dsc_installdir] = true}.to raise_error(Puppet::ResourceError)
  end

  it 'should not accept int for dsc_installdir' do
    expect{dsc_choclatey[:dsc_installdir] = -16}.to raise_error(Puppet::ResourceError)
  end

  it 'should not accept uint for dsc_installdir' do
    expect{dsc_choclatey[:dsc_installdir] = 16}.to raise_error(Puppet::ResourceError)
  end

  it 'should not accept array for dsc_chocoinstallscripturl' do
    expect{dsc_choclatey[:dsc_chocoinstallscripturl] = ["foo", "bar", "spec"]}.to raise_error(Puppet::ResourceError)
  end

  it 'should not accept boolean for dsc_chocoinstallscripturl' do
    expect{dsc_choclatey[:dsc_chocoinstallscripturl] = true}.to raise_error(Puppet::ResourceError)
  end

  it 'should not accept int for dsc_chocoinstallscripturl' do
    expect{dsc_choclatey[:dsc_chocoinstallscripturl] = -16}.to raise_error(Puppet::ResourceError)
  end

  it 'should not accept uint for dsc_chocoinstallscripturl' do
    expect{dsc_choclatey[:dsc_chocoinstallscripturl] = 16}.to raise_error(Puppet::ResourceError)
  end

  # Configuration PROVIDER TESTS

  describe "powershell provider tests" do

    it "should successfully instanciate the provider" do
      described_class.provider(:powershell).new(dsc_choclatey)
    end

    before(:each) do
      @provider = described_class.provider(:powershell).new(dsc_choclatey)
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

  end
end
