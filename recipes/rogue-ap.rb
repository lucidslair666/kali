# -*- coding: utf-8 -*-
#
# Cookbook Name:: kali
# Recipe:: rogue-ap
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

node['kali']['rogue-ap']['packages'].each do |pkg|
  package pkg
end

cookbook_file '/etc/init.d/hostapd' do
  source 'hostapd.init'
  mode '0755'
end

template '/etc/dnsmasq.conf' do
  source 'dnsmasq.conf.erb'
  mode '0644'
end

template '/etc/hostapd/hostapd.conf' do
  source 'hostapd.conf.erb'
  mode '0644'
end

template node['kali']['rogue-ap']['script_path'] do
  source 'rogue-ap.sh.erb'
  mode '0755'
  variables interface: node['kali']['rogue-ap']['interface'],
            out_interface: node['kali']['rogue-ap']['out_interface']
end
