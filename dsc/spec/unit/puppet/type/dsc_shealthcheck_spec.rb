#!/usr/bin/env ruby
require 'spec_helper'

describe Puppet::Type.type(:dsc_shealthcheck) do

  let :dsc_shealthcheck do
    Puppet::Type.type(:dsc_shealthcheck).new(
      :name     => 'foo',
      :dsc_strcomputer => 'foo',
    )
  end

  it 'should allow all properties to be specified' do
    expect { Puppet::Type.type(:dsc_shealthcheck).new(
      :name     => 'foo',
      :dsc_strcomputer => 'foo',
    )}.to_not raise_error
  end

  it "should stringify normally" do
    expect(dsc_shealthcheck.to_s).to eq("Dsc_shealthcheck[foo]")
  end

  it 'should require that dsc_strcomputer is specified' do
    #dsc_shealthcheck[:dsc_strcomputer]
    expect { Puppet::Type.type(:dsc_shealthcheck).new(
      :name     => 'foo',
    )}.to raise_error(Puppet::Error, /dsc_strcomputer is a required attribute/)
  end

  it 'should not accept array for dsc_strcomputer' do
    expect{dsc_shealthcheck[:dsc_strcomputer] = ["foo", "bar", "spec"]}.to raise_error(Puppet::ResourceError)
  end

  it 'should not accept boolean for dsc_strcomputer' do
    expect{dsc_shealthcheck[:dsc_strcomputer] = true}.to raise_error(Puppet::ResourceError)
  end

  it 'should not accept int for dsc_strcomputer' do
    expect{dsc_shealthcheck[:dsc_strcomputer] = -16}.to raise_error(Puppet::ResourceError)
  end

  it 'should not accept uint for dsc_strcomputer' do
    expect{dsc_shealthcheck[:dsc_strcomputer] = 16}.to raise_error(Puppet::ResourceError)
  end

  # Configuration PROVIDER TESTS

  describe "powershell provider tests" do

    it "should successfully instanciate the provider" do
      described_class.provider(:powershell).new(dsc_shealthcheck)
    end

    before(:each) do
      @provider = described_class.provider(:powershell).new(dsc_shealthcheck)
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
