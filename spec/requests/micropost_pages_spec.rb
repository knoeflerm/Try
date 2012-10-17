require 'spec_helper'

describe "Micropost pages" do

  subject { page }
  
  describe "pagination" do
    let(:user) { FactoryGirl.create(:user) }
    before do
      sign_in user
      visit root_path
    end
    before(:all) do
      (1..31).each do |i|
          FactoryGirl.create(:micropost, user: user, content: "#{i} Lorem ipsum")
      end
    end
    after(:all)  { Micropost.delete_all }
    after(:all) { User.delete_all }
    it { should have_link('Next') }
    it { should have_link('2') }
    let(:first_page)  { Micropost.paginate(page: 1) }
    let(:second_page) { Micropost.paginate(page: 2) }
    it "should list the first page of the user's microposts" do
      first_page.each do |post|
        page.should have_selector("tr##{post.id}", text: post.content)
      end
    end
  end
  
  describe "general" do
    let(:user) { FactoryGirl.create(:user) }
    before { sign_in user }
    describe "micropost creation" do
      before { visit root_path }
      describe "with invalid information" do
        it "should not create a micropost" do
          expect { click_button "Submit" }.to_not change(Micropost, :count)
        end
        describe "error messages" do
          let(:error) { '1 error prohibited this micropost from being saved' }
          before { click_button "Submit" }
          it { should have_content(error) } 
        end
      end
      describe "with valid information" do
        before { fill_in 'micropost_content', with: "Lorem ipsum" }
        it "should create a micropost" do
          expect { click_button "Submit" }.to change(Micropost, :count).by(1)
        end
      end
    end
    describe "micropost destruction" do
      before { FactoryGirl.create(:micropost, user: user) }
      describe "as correct user" do
        before { visit root_path }
        it "should delete a micropost" do
          expect { click_link "delete" }.to change(Micropost, :count).by(-1)
        end
      end
    end
  end
  
  describe "authorization" do
    let(:user1) { FactoryGirl.create(:user) }
    let(:user2) { FactoryGirl.create(:user) }
    before { sign_in user1 }
    before(:all) do
      (1..2).each do |i|
          FactoryGirl.create(:micropost, user: user1, content: "#{i} Lorem ipsum user1")
          FactoryGirl.create(:micropost, user: user2, content: "#{i} Lorem ipsum user2")
      end
    end
    after(:all)  { Micropost.delete_all }
    after(:all) { User.delete_all }
    describe "as signed-in user" do
      before { visit user_path(user1) }
      it { should have_link('delete') }
    end
    describe "as non-signed-in user" do
      before { visit user_path(user2) }
      it { should_not have_link('delete') }
    end
  end
end