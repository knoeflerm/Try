class Address < ActiveRecord::Base
  attr_accessible :name, :surname, :street, :streetnumber, :zipcode, :town, :link
  belongs_to :user
  
  validates :name, presence: true, length: { maximum: 50 }
  validates :surname, presence: true, length: { maximum: 50 }
  validates :street, presence: true, length: { maximum: 50 }
  validates :streetnumber, presence: true, :numericality => true
  validates :zipcode, presence: true, :numericality => true
  validates :town, presence: true, length: { maximum: 50 }
  validates_format_of :link, :with => /^(http|https):\/\/[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}(:[0-9]{1,5})?(\/.*)?$/ix
end
