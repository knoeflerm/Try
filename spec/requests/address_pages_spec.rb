require 'spec_helper'

describe "Address pages" do

  subject { page }

  describe "index" do

    let(:user) { FactoryGirl.create(:user) }

    before do
      sign_in user
      visit address_path(user)
    end
    it { should have_selector('title', text: 'Your addresses') }
    
    describe "as non admin user" do
      let!(:address) { FactoryGirl.create(:address, user: user) }
      before { visit user_path(user) }
      it { should have_content("Addresses #{user.addresses.count}") }
      it { should have_link('Addresses', href: address_path(user)) }
    end
    
    describe "as admin user" do
      let(:admin) { FactoryGirl.create(:admin) }
      let!(:address) { FactoryGirl.create(:address, user: admin) }
      let!(:address2) { FactoryGirl.create(:address, user: user) }
      before do
        sign_in admin
        visit user_path(admin)
      end
      it { should have_content("Addresses 2") }
      it { should have_link('Addresses', href: address_path(admin)) }
      
      describe "admin user's title" do
        before do
          sign_in admin
          visit address_path(admin)
        end
        it { should have_selector('title', text: 'All addresses') }
      end
      
      describe "index title when admin is signed in" do
        before do
          sign_in admin
          visit addresses_path
        end
        it { should have_selector('title', text: 'All addresses') }
      end
    end
  end
  
  describe "show" do
    
  end
  
  describe "Authorization" do
    
  end
end
