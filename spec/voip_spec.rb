# -*- coding: utf-8 -*-

require_relative 'spec_helper'

describe 'kali::voip' do
  subject { ChefSpec::ServerRunner.new.converge(described_recipe) }

  it 'installs package[kali-linux-voip]' do
    expect(subject).to install_package('kali-linux-voip').with(timeout: 1800)
  end
end
