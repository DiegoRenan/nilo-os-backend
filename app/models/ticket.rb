# == Schema Information
#
# Table name: tickets
#
#  id               :uuid             not null, primary key
#  body             :text
#  conclude_at      :date
#  title            :string
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  company_id       :uuid
#  department_id    :uuid
#  employee_id      :uuid
#  priority_id      :uuid
#  sector_id        :uuid
#  ticket_status_id :uuid
#  ticket_type_id   :uuid
#
# Indexes
#
#  index_tickets_on_company_id        (company_id)
#  index_tickets_on_department_id     (department_id)
#  index_tickets_on_employee_id       (employee_id)
#  index_tickets_on_priority_id       (priority_id)
#  index_tickets_on_sector_id         (sector_id)
#  index_tickets_on_ticket_status_id  (ticket_status_id)
#  index_tickets_on_ticket_type_id    (ticket_type_id)
#
# Foreign Keys
#
#  fk_rails_...  (department_id => departments.id)
#  fk_rails_...  (employee_id => employees.id)
#  fk_rails_...  (priority_id => priorities.id)
#  fk_rails_...  (sector_id => sectors.id)
#  fk_rails_...  (ticket_status_id => ticket_statuses.id)
#  fk_rails_...  (ticket_type_id => ticket_types.id)
#

class Ticket < ApplicationRecord
  
  #Associations
  belongs_to :company do
    #HATEOAS 
    link(:related) { v1_ticket_company_url(object.id)}
  end

  belongs_to :department, optional: true
  belongs_to :sector, optional: true
  belongs_to :employee
  belongs_to :ticket_status
  belongs_to :ticket_type
  belongs_to :priority, optional: true
  

  has_many :responsibles, dependent: :destroy
  has_many :employees, :through => :responsibles
  has_many :comments, dependent: :destroy

  #Validations
  validates :title, presence: true, length: { maximum: 500 }
  validates :body, presence: true, length: { maximum: 20000 }

  def open
    ActiveRecord::Base.transaction do
      opened = TicketStatus.where(status: "ABERTO")
      update_attribute(:ticket_status_id, opened.take.id)
    end
  end

  def close
    ActiveRecord::Base.transaction do 
      aguardando = TicketStatus.where(status: "AGUARDANDO_APROVAÇÃO")
      update_attribute(:ticket_status_id, aguardando.take.id)
    end
  end

  def aprove
    ActiveRecord::Base.transaction do
      conclude = TicketStatus.where(status: "CONCLUÍDO")
      update_attribute(:ticket_status_id, conclude.take.id)
    end
  end

  def set_plan
    ActiveRecord::Base.transaction do
      plan = Priority.where(nivel: "plan")
      update_attribute(:priority_id, plan.take.id)
    end
  end

  def self.where_responsible(tec)
    tickets = []
    Ticket.all.each do |ticket|
      if ticket.responsibles.exists?
        responsibles = ticket.responsibles.map { |r| r.employee_id }
        if responsibles.include?(tec.id)
          tickets.push(ticket)
        end
      end
    end
    tickets
  end

  def self.user_tickets(user)
    if user.employee.tickets.exists?
      user.employee.tickets.map { |ticket| ticket }
    else 
      return []
    end
  end

  def self.employee_department_tickets(employee)
    if employee.department.present?
      employee.department.tickets
    else 
      return []
    end
  end

end
