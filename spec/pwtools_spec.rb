# -*- coding: utf-8 -*-

require_relative 'spec_helper'

describe 'kali::pwtools' do
  subject { ChefSpec::ServerRunner.new.converge(described_recipe) }

  it 'does install kali-linux-pwtools package' do
    expect(subject).to install_package('kali-linux-pwtools')
  end
end