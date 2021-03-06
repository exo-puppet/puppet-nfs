require 'spec_helper'
describe 'nfs::client::ubuntu' do

  it do
    should contain_class('nfs::client::ubuntu::install')
    should contain_class('nfs::client::ubuntu::configure')
    should contain_class('nfs::client::ubuntu::service')

    should contain_service('rpcbind').with(
      'ensure' => 'running'
    )

    should contain_service('idmapd').with(
      'ensure' => 'stopped'
    )
    should contain_package('nfs-common')
    should contain_package('rpcbind')
    
    should contain_package('nfs4-acl-tools')
  end
  context ":nfs_v4 => true" do
    let(:params) {{ :nfs_v4 => true }}
    it do
      should contain_augeas('/etc/idmapd.conf') 
      should contain_service('idmapd').with(
        'ensure' => 'running'
      )
    end
  end

end
