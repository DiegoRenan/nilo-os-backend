# == Schema Information
#
# Table name: tickets
#
#  id          :uuid             not null, primary key
#  body        :text
#  conclude_at :date
#  title       :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  company_id  :uuid
#
# Indexes
#
#  index_tickets_on_company_id  (company_id)
#

require 'test_helper'

class TicketTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
