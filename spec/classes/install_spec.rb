require 'spec_helper'

describe 'es_lite::install' do
  on_supported_os.each do |os, os_facts|
    context "on #{os}" do
      let(:facts) { os_facts }

      let :pre_condition do
        "class { 'es_lite': }"
      end

      it { is_expected.to compile }
    end
  end
end
