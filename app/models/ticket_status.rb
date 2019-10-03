# == Schema Information
#
# Table name: ticket_statuses
#
#  id         :uuid             not null, primary key
#  status     :string           default("ABERTO")
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class TicketStatus < ApplicationRecord
   #before actions
   before_save { self.status = status.upcase }

   #Associations
   has_many :tickets

   #validations
   validates :status, presence: true, length: { minimum: 2, maximum: 200 }, uniqueness: { case_sensitive: false }
end
