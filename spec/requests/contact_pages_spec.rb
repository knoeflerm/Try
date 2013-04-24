require 'spec_helper'

describe "Contact pages" do

  subject { page }

  describe "show" do
    describe "as a non admin user" do
      let(:user) { FactoryGirl.create(:user) }
      let!(:address) { FactoryGirl.create(:address, user: user) }
      
      before do
        visit contact_path
      end
      
      it { should have_selector('title', text: 'Contact') }
      it { should have_selector('h1', text: 'Contact') }
      it { should_not have_selector('iframe') }
      it { should_not have_link('View Larger Map') } 
      it { should_not have_content("#{address.name}") }
      it { should_not have_content("#{address.surname}") }
      it { should_not have_content("#{address.street}") }
      it { should_not have_content("#{address.streetnumber}") }
      it { should_not have_content("#{address.zipcode}") }
      it { should_not have_content("#{address.town}") }
    end
    describe "as an admin user" do
      let(:user) { FactoryGirl.create(:admin) }
      let!(:address) { FactoryGirl.create(:address, user: user) }
      
      before do
        visit contact_path
      end
      it { should have_selector('title', text: 'Contact') }
      it { should have_selector('h1', text: 'Contact') }
      it { should have_selector('iframe') }
      it { should have_link('View Larger Map') }
      it { should have_content("#{address.name}") }
      it { should have_content("#{address.surname}") }
      it { should have_content("#{address.street}") }
      it { should have_content("#{address.streetnumber}") }
      it { should have_content("#{address.zipcode}") }
      it { should have_content("#{address.town}") }
    end      
  end
end