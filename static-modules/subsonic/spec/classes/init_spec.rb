require 'spec_helper'
describe 'subsonic' do

  context 'with defaults for all parameters' do
    it { should contain_class('subsonic') }
  end
end
