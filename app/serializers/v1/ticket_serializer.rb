module V1
  class TicketSerializer < ActiveModel::Serializer
    attributes :id, 
               :title, 
               :body, 
               :created, 
               :conclude,
               :concludef, 
               :updated, 
               :author, 
               :responsibles, 
               :department_id, 
               :sector_id,
               :ticket_status_id, 
               :ticket_type_id, 
               :priority_id, 
               :nivel, 
               :status

    belongs_to :company
    belongs_to :department
    belongs_to :sector
    belongs_to :ticket_status
    belongs_to :ticket_type
    belongs_to :employee
    belongs_to :priority

    def created
      I18n.l object.created_at
    end
    
    def conclude
     object.conclude_at&.strftime("%Y-%m-%d")
    end

    def concludef
      object.conclude_at&.strftime("%d/%m/%Y")
    end

    def status
      object.ticket_status&.status
    end

    def updated
      I18n.l object.updated_at
    end

    def nivel
      object.priority&.nivel
    end

    def author
      { 
        name: object.employee.name,
        email: object.employee.email,
        id: object.employee.id
      }
    end

    def responsibles
       responsibles = object&.responsibles.map { |resp| resp.employee.name}
    end
  
    def attributes(*args)
      h = super(*args)
      h[:conclude_at] = object.conclude_at.to_time.iso8601 unless object.conclude_at.blank?
      h[:created_at] = object.created_at.to_time.iso8601 unless object.created_at.blank?
      h[:updated_at] = object.updated_at.to_time.iso8601 unless object.updated_at.blank?
      h
    end
  end  
end
