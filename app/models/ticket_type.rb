# == Schema Information
#
# Table name: ticket_types
#
#  id         :uuid             not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class TicketType < ApplicationRecord
  #before actions
  before_save { self.name = name.upcase }

  #Associations
  has_many :tickets

  #validations
  validates :name, presence: true, length: { minimum: 2, maximum: 200 }, uniqueness: { case_sensitive: false }
end
