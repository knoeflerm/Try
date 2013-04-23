require 'spec_helper'

describe Address do

  let(:user) { FactoryGirl.create(:user) }
  before { @address = user.addresses.build(name: "Name", surname: "Surname", street: "Street", streetnumber: 6, zipcode: 1000, town: "Town", link: "http://www.example.com") }

  subject { @address }

  it { should respond_to(:user_id) }
  it { should respond_to(:name) }
  it { should respond_to(:surname) }
  it { should respond_to(:street) }
  it { should respond_to(:streetnumber) }
  it { should respond_to(:zipcode) }
  it { should respond_to(:town) }
  it { should respond_to(:link) }
  it { should respond_to(:phone) }
  it { should respond_to(:mobile) }
  
  it { should be_valid }
  
  describe "when name is not present" do
    before { @address.name = " " }
    it { should_not be_valid }
  end
  describe "when surname is not present" do
    before { @address.surname = " " }
    it { should_not be_valid }
  end
  describe "when street is not present" do
    before { @address.street = " " }
    it { should_not be_valid }
  end
  describe "when streetnumber is not present" do
    before { @address.streetnumber = nil }
    it { should_not be_valid }
  end
  describe "when zipcode is not present" do
    before { @address.zipcode = nil }
    it { should_not be_valid }
  end
  describe "when town is not present" do
    before { @address.town = " " }
    it { should_not be_valid }
  end
  describe "when link is not present" do
    before { @address.link = " " }
    it { should_not be_valid }
  end
  #FIXME: re-introduce following regex when solution for google map on contact page is found
  #describe "when link is not valid" do
    #before { @address.link = "hallo.ch" }
    #it { should_not be_valid }
  #end
  describe "when phone is not valid" do
    before { @address.phone = "+123456789111" }
    it { should_not be_valid }
  end
  describe "when mobile is not valid" do
    before { @address.mobile = "+123456789111" }
    it { should_not be_valid }
  end
end
