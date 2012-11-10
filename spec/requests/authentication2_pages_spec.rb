require 'spec_helper'

describe "Authorization" do
  subject { page }

  describe "for non-signed-in users" do      
    describe "in the Addresses controller" do
      let(:user) { FactoryGirl.create(:user) }
      
      before { get addresses_path }
      specify { response.should redirect_to(signin_path) }
      
      describe "submitting to the destroy action" do
        before { delete address_path(1) }
        specify { response.should redirect_to(signin_path) }          
      end
      describe "visiting the edit page" do
        before { visit edit_address_path(user) }
        it { should have_selector('title', text: 'Sign in') }
      end
      describe "submitting to the create action" do
        before { post addresses_path }
        specify { response.should redirect_to(signin_path) }
      end
      describe "submitting to the update action" do
        before { put address_path(user) }
        specify { response.should redirect_to(signin_path) }
      end
      describe "visiting the address index" do
        before { visit addresses_path }
        it { should have_selector('title', text: 'Sign in') }
      end
      describe "visiting the address" do
        before { visit address_path(user) }
        it { should have_selector('title', text: 'Sign in') }
      end      
    end
  end
  
  describe "for signed-in users" do
    let(:user) { FactoryGirl.create(:user) }
    let(:user2) { FactoryGirl.create(:user) }
    before { sign_in user }
    describe "visit other user's address" do
      before { visit address_path(user2) }
      it { should have_selector('title', text: 'Home') }
    end
  end
end
