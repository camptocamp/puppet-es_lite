require 'spec_helper_acceptance'

describe 'es_lite class' do
  describe 'when running puppet code' do
    let(:pp) do
      <<-MANIFEST
        class { 'es_lite': }
      MANIFEST
    end

    it 'applies the manifest twice with no stderr' do
      idempotent_apply(pp)
    end
  end
end
