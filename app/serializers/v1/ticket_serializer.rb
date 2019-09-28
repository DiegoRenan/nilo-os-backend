module V1
  class TicketSerializer < ActiveModel::Serializer
    attributes :id, :title, :body, :conclude_at, :nivel, :author, :responsibles
  
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
      h
    end
  end  
end
