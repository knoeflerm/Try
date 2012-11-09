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
    
    describe "for signed-in users" do
      before do
        sign_in user
        visit new_address_path
      end
  
      describe "page" do
        it { should have_selector('h1',    text: "New address") }
        it { should have_selector('title', text: "New address") }
      end
    
      describe "with invalid information" do
        it "should not create an address" do
          expect { click_button "Save" }.not_to change(Address, :count)
        end
        
        describe "error messages" do
          before { click_button "Save" }
    
          let(:error) { '10 errors prohibited this address from being saved' }
          let(:nameblank) { "Name can't be blank" }
          let(:surnameblank) { "Surname can't be blank" }
          let(:streetblank) { "Street can't be blank" }
          let(:streetnumberblank) { "Streetnumber can't be blank" }
          let(:streetnumbernotanumber) { "Streetnumber is not a number" }
          let(:zipcode) { "Zipcode can't be blank" }
          let(:zipcodenotanumber) { "Zipcode is not a number" }
          let(:town) { "Town can't be blank" }
          let(:link) { "Link can't be blank" }
          let(:linkinvalid) { "Link is invalid" }
    
          it { should have_selector('title', text: 'New address') }
          it { should have_content(error) }
          it { should have_content(nameblank) }
          it { should have_content(surnameblank) }
          it { should have_content(streetblank) }
          it { should have_content(streetnumberblank) }
          it { should have_content(zipcode) }
          it { should have_content(town) }
          it { should have_content(link) }
          it { should have_content(linkinvalid) }
        end
      end
      
      describe "with valid information" do
        before do
          fill_in "Name",         with: "Name"
          fill_in "Surname",      with: "Surname"
          fill_in "Street",       with: "Street"
          fill_in "Streetnumber", with: 99
          fill_in "Zipcode",      with: 9999
          fill_in "Town",         with: "Town"
          fill_in "Link",         with: "http://www.link.com"
        end
  
        it "should create an address" do
          expect { click_button "Save" }.to change(Address, :count).by(1)
        end
        
        describe "after successfully saving the address" do
          before { click_button "Save" }
          let(:newaddress) { Address.find_by_user_id(user.id) }
  
          it { should have_selector('title', text: 'Your addresses') }
          it { should have_selector('div.flash.success', text: 'Address saved') }
          it { should have_content(newaddress.name) }
          it { should have_link("#{newaddress.name}, #{newaddress.street}, #{newaddress.town}", href: edit_address_path(newaddress)) }
          it { should have_link('delete', href: address_path(newaddress)) }
        end
      end         
    end
  end
  
  describe "edit" do
    describe "for signed-in users" do
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
      
      describe "as wrong user" do
        let(:otheruser) { FactoryGirl.create(:user) }
        let(:otheraddress) { FactoryGirl.create(:address, user: otheruser) }
        before { visit edit_address_path(otheraddress) }
        describe "page" do
          it { should have_selector('title', text: 'Home')}
        end
      end
    
      describe "with valid information" do
        let(:name)  { "New Name" }
        let(:surname) { "New Surname" }
        let(:street)  { "New Street" }
        let(:streetnumber)  { 99 }
        let(:zipcode)  { 9999 }
        let(:town)  { "New Town" }
        let(:link)  { "http://www.newlink.com" }
        before do
          fill_in "Name",         with: name
          fill_in "Surname",      with: surname
          fill_in "Street",       with: street
          fill_in "Streetnumber", with: streetnumber
          fill_in "Zipcode",      with: zipcode
          fill_in "Town",         with: town
          fill_in "Link",         with: link
          click_button "Update"
        end
  
        let(:editedaddress) { Address.find_by_user_id(user.id) }
        
        it { should have_selector('title', text: "Your addresses") }
        it { should have_selector('div.flash.success', text: 'Address updated') }
        it { should have_link("#{name}, #{street}, #{town}", href: edit_address_path(editedaddress)) }
        specify { address.reload.name.should  == name }
        specify { address.reload.surname.should == surname }
        specify { address.reload.street.should == street }
        specify { address.reload.streetnumber.should == streetnumber }
        specify { address.reload.zipcode.should == zipcode }
        specify { address.reload.town.should == town }
        specify { address.reload.link.should == link }        
      end
    end
  end
end
