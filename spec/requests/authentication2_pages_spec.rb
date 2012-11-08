require 'spec_helper'

describe "Authorization" do

  subject { page }

  describe "for non-signed-in users" do      
    describe "in the Addresses controller" do
      before { get addresses_path }
      specify { response.should redirect_to(signin_path) }
      
      describe "when not signed in" do
        describe "submitting to the destroy action" do
          before { delete address_path(1) }
          specify { response.should redirect_to(signin_path) }          
        end
      end
    end
  end
end
