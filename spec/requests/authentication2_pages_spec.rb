require 'spec_helper'

describe "Authorization" do

  subject { page }

  describe "for non-signed-in users" do      
    describe "in the Addresses controller" do
      before { get addresses_path }
      specify { response.should redirect_to(signin_path) }
    end
  end
end
