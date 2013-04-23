require 'spec_helper'

describe "Contact pages" do

  subject { page }

  describe "show" do
    let(:user) { FactoryGirl.create(:admin) }
    let!(:address) { FactoryGirl.create(:address, user: user) }
    
    before do
      visit contact_path
    end
    it { should have_selector('title', text: 'Contact') }
    it { should have_selector('h1',    text: 'Contact') }
  end
end