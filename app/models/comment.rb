# == Schema Information
#
# Table name: comments
#
#  id          :uuid             not null, primary key
#  body        :text
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  employee_id :uuid
#  ticket_id   :uuid
#
# Indexes
#
#  index_comments_on_employee_id  (employee_id)
#  index_comments_on_ticket_id    (ticket_id)
#
# Foreign Keys
#
#  fk_rails_...  (employee_id => employees.id)
#  fk_rails_...  (ticket_id => tickets.id)
#

class Comment < ApplicationRecord
  belongs_to :employee
  belongs_to :ticket

  validates :body, presence: true, length: { maximum: 20000 }
end
