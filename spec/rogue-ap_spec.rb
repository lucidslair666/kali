# -*- coding: utf-8 -*-

require_relative 'spec_helper'

describe 'kali::rogue-ap' do
  subject { ChefSpec::ServerRunner.new.converge(described_recipe) }

  %w(hostapd dnsmasq wireless-tools iw wvdial).each do |pkg|
    it "installs package[#{pkg}]" do
      expect(subject).to install_package(pkg)
    end
  end

  it 'creates cookbook_file[/etc/init.d/hostapd]' do
    expect(subject).to create_cookbook_file('/etc/init.d/hostapd')
      .with(source: 'hostapd.init',
            mode: '0755')
  end

  it 'creates template[/etc/dnsmasq.conf]' do
    expect(subject).to create_template('/etc/dnsmasq.conf')
      .with(source: 'dnsmasq.conf.erb',
            mode: '0644')

    [%r{^log-facility=/var/log/dnsmasq.log$},
     /^interface=wlan0$/,
     /^dhcp-range=10.0.0.10,10.0.0.250,12h$/,
     /^dhcp-option=3,10.0.0.1$/,
     /^dhcp-option=6,10.0.0.1$/].each do |match|
      expect(subject).to render_file('/etc/dnsmasq.conf')
        .with_content(match)
    end
  end

  it 'creates template[/etc/hostapd/hostapd.conf]' do
    expect(subject).to create_template('/etc/hostapd/hostapd.conf')
      .with(source: 'hostapd.conf.erb',
            mode: '0644')

    [/^interface=wlan0$/,
     /^driver=nl80211$/,
     /^ssid=FreeWifi$/,
     /^channel=1$/].each do |match|
      expect(subject).to render_file('/etc/hostapd/hostapd.conf')
        .with_content(match)
    end
  end

  it 'creates template[/root/rogue-ap.sh]' do
    expect(subject).to create_template('/root/rogue-ap.sh')
      .with(source: 'rogue-ap.sh.erb',
            mode: '0755',
            variables: {
              interface: 'wlan0',
              out_interface: 'eth0',
            })
  end
end
