class Category < ActiveRecord::Base
  attr_accessible :name

  validates_presence_of :name

  has_many :events

  default_scope order('id ASC')
end