# == Schema Information
#
# Table name: priorities
#
#  id         :uuid             not null, primary key
#  nivel      :string           default("plan")
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'rails_helper'

RSpec.describe Priority, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
