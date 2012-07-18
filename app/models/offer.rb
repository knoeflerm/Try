class Offer < ActiveRecord::Base
  validates :description,  :presence => true
  validates :title, :presence => true, :length => { :minimum => 5 }
  validates :price, :presence => true
  validates :price, :numericality => true
end
