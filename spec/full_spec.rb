# -*- coding: utf-8 -*-

require_relative 'spec_helper'

describe 'kali::full' do
  subject { ChefSpec::ServerRunner.new.converge(described_recipe) }

  it 'installs package[kali-linux-full]' do
    expect(subject).to install_package('kali-linux-full').with(timeout: 1800)
  end
end
