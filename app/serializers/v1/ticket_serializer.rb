module V1
  class TicketSerializer < ActiveModel::Serializer
    attributes :id, :title, :body, :conclude_at, :nivel, :author, :responsibles, :created, :updated

    belongs_to :company
    belongs_to :department
    belongs_to :sector
    belongs_to :ticket_status
    belongs_to :ticket_type
    belongs_to :employee

    def created
      object.created_at
    end
    
    def updated
      object.updated_at
    end

    def nivel
      object.priority.nivel
    end

    def author
      object.employee.name
    end

    def responsibles
      responsibles = object.employees || []
      names = []
      unless responsibles.empty?
        responsibles.each do |responsible|
          names.push(responsible.name)
        end
      end
      names
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
