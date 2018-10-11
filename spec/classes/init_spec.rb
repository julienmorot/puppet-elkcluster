require 'spec_helper'
describe 'elkcluster' do
  context 'with default values for all parameters' do
    it { should contain_class('elkcluster') }
  end
end
