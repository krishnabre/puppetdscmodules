#!/usr/bin/env ruby
require 'spec_helper'

describe Puppet::Type.type(:dsc_chocoinstall) do

  let :dsc_chocoinstall do
    Puppet::Type.type(:dsc_chocoinstall).new(
      :name     => 'foo',
      :dsc_name => 'foo',
    )
  end

  it 'should allow all properties to be specified' do
    expect { Puppet::Type.type(:dsc_chocoinstall).new(
      :name     => 'foo',
      :dsc_name => 'foo',
      :dsc_params => 'foo',
      :dsc_version => 'foo',
      :dsc_source => 'foo',
    )}.to_not raise_error
  end

  it "should stringify normally" do
    expect(dsc_chocoinstall.to_s).to eq("Dsc_chocoinstall[foo]")
  end

  it 'should require that dsc_name is specified' do
    #dsc_chocoinstall[:dsc_name]
    expect { Puppet::Type.type(:dsc_chocoinstall).new(
      :name     => 'foo',
    )}.to raise_error(Puppet::Error, /dsc_name is a required attribute/)
  end

  it 'should not accept array for dsc_name' do
    expect{dsc_chocoinstall[:dsc_name] = ["foo", "bar", "spec"]}.to raise_error(Puppet::ResourceError)
  end

  it 'should not accept boolean for dsc_name' do
    expect{dsc_chocoinstall[:dsc_name] = true}.to raise_error(Puppet::ResourceError)
  end

  it 'should not accept int for dsc_name' do
    expect{dsc_chocoinstall[:dsc_name] = -16}.to raise_error(Puppet::ResourceError)
  end

  it 'should not accept uint for dsc_name' do
    expect{dsc_chocoinstall[:dsc_name] = 16}.to raise_error(Puppet::ResourceError)
  end

  it 'should not accept array for dsc_params' do
    expect{dsc_chocoinstall[:dsc_params] = ["foo", "bar", "spec"]}.to raise_error(Puppet::ResourceError)
  end

  it 'should not accept boolean for dsc_params' do
    expect{dsc_chocoinstall[:dsc_params] = true}.to raise_error(Puppet::ResourceError)
  end

  it 'should not accept int for dsc_params' do
    expect{dsc_chocoinstall[:dsc_params] = -16}.to raise_error(Puppet::ResourceError)
  end

  it 'should not accept uint for dsc_params' do
    expect{dsc_chocoinstall[:dsc_params] = 16}.to raise_error(Puppet::ResourceError)
  end

  it 'should not accept array for dsc_version' do
    expect{dsc_chocoinstall[:dsc_version] = ["foo", "bar", "spec"]}.to raise_error(Puppet::ResourceError)
  end

  it 'should not accept boolean for dsc_version' do
    expect{dsc_chocoinstall[:dsc_version] = true}.to raise_error(Puppet::ResourceError)
  end

  it 'should not accept int for dsc_version' do
    expect{dsc_chocoinstall[:dsc_version] = -16}.to raise_error(Puppet::ResourceError)
  end

  it 'should not accept uint for dsc_version' do
    expect{dsc_chocoinstall[:dsc_version] = 16}.to raise_error(Puppet::ResourceError)
  end

  it 'should not accept array for dsc_source' do
    expect{dsc_chocoinstall[:dsc_source] = ["foo", "bar", "spec"]}.to raise_error(Puppet::ResourceError)
  end

  it 'should not accept boolean for dsc_source' do
    expect{dsc_chocoinstall[:dsc_source] = true}.to raise_error(Puppet::ResourceError)
  end

  it 'should not accept int for dsc_source' do
    expect{dsc_chocoinstall[:dsc_source] = -16}.to raise_error(Puppet::ResourceError)
  end

  it 'should not accept uint for dsc_source' do
    expect{dsc_chocoinstall[:dsc_source] = 16}.to raise_error(Puppet::ResourceError)
  end

  # Configuration PROVIDER TESTS

  describe "powershell provider tests" do

    it "should successfully instanciate the provider" do
      described_class.provider(:powershell).new(dsc_chocoinstall)
    end

    before(:each) do
      @provider = described_class.provider(:powershell).new(dsc_chocoinstall)
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
