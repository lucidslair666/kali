# -*- coding: utf-8 -*-

require_relative 'spec_helper'

describe 'kali::full' do
  subject { ChefSpec::ServerRunner.new.converge(described_recipe) }

  it 'does install kali-linux-full package' do
    expect(subject).to install_package('kali-linux-full')
  end
end