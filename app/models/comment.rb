class Comment < ApplicationRecord
  belongs_to :employee
  belongs_to :ticket
end
