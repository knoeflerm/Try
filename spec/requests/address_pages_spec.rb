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
    describe "as a non admin user" do
      let(:user) { FactoryGirl.create(:user) }
      let(:user2) { FactoryGirl.create(:user) }
      let!(:address) { FactoryGirl.create(:address, user: user) }
      let!(:address2) { FactoryGirl.create(:address, user: user2) }
      before do
        sign_in user
        visit address_path(user)
      end
      it { should have_link('delete', href: address_path(address)) }
      it { should_not have_link('delete', href: address_path(address2)) }
      it "should be able to delete his address" do
        expect { click_link('delete') }.to change(Address, :count).by(-1)
      end
    end
    
    describe "as an admin user" do
      let(:admin) { FactoryGirl.create(:admin) }
      let(:user) { FactoryGirl.create(:user) }
      let!(:address) { FactoryGirl.create(:address, user: admin) }
      let!(:address2) { FactoryGirl.create(:address, user: user) }
      before do
        sign_in admin
        visit address_path(admin)
      end
      it { should have_link('delete', href: address_path(address)) }
      it { should have_link('delete', href: address_path(address2)) }
      it "should be able to delete his address" do
        expect { click_link('delete') }.to change(Address, :count).by(-1)  
      end
    end
  end
  
  describe "new" do
    let(:user) { FactoryGirl.create(:user) }
    let(:address) { FactoryGirl.create(:address, user: user) }
    before do
      sign_in user
      visit new_address_path(address)
    end

    describe "page" do
      it { should have_selector('h1',    text: "New address") }
      it { should have_selector('title', text: "New address") }
    end
  end
  
  describe "edit" do
    let(:user) { FactoryGirl.create(:user) }
    let(:address) { FactoryGirl.create(:address, user: user) }
    before do
      sign_in user
      visit edit_address_path(address)
    end
    describe "page" do
      it { should have_selector('h1',    text: "Edit address") }
      it { should have_selector('title', text: "Edit address") }
    end
  end
end
