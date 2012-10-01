# == Schema Information
#
# Table name: offers
#
#  id          :integer(4)      not null, primary key
#  title       :string(255)
#  description :text
#  price       :float
#  created_at  :datetime        not null
#  updated_at  :datetime        not null
#

require 'test_helper'

class OfferTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
