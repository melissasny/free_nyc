class Event < ActiveRecord::Base
#  attr_accessible :address, :borough, :days_of_week, :end_date, :name, :start_date, :start_time, :website, :category_id, :notes

  validates_presence_of :name
  validates_presence_of :website
  validates_presence_of :category_id
  validates_presence_of :borough
  validates_presence_of :address
  validates_presence_of :start_date
  validates_length_of :start_date, is:6
  validates_presence_of :end_date
  validates_length_of :end_date, is:6
  validates_presence_of :days_of_week
  
  belongs_to :category

  default_scope order('name ASC')
  
end