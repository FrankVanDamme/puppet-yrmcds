require 'spec_helper'
describe 'yrmcds' do
  context 'with default values for all parameters' do
    it { should contain_class('yrmcds') }
  end
end
