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

class Offer < ActiveRecord::Base
  validates :description,  :presence => true
  validates :title, :presence => true, :length => { :minimum => 5 }
  validates :price, :presence => true
  validates :price, :numericality => true
end
