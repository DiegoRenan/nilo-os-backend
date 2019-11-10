namespace :dev do
  desc "Configura o ambiente de desenvolvimento"
    
  task setup: :environment do

    # puts "Resetando o banco de dados"
    
    # %x(rails db:drop db:create db:migrate)

    ###############################################33
    ActiveRecord::Base.transaction do
      puts "Cadastrando Companies..."

      companies = %w(Geral Matriz Shopping Posto Atacadão)

      
      companies.each do |company|
        Company.create!(
          name: company
        )
      end
      

      puts "Companies cadastradas com sucesso!"

      ###############################################33

      puts "Cadastrando Departments..."

      company_matriz = Company.where(name: "MATRIZ").take
      company_shopping = Company.where(name: "SHOPPING").take

      rh_matriz = Department.create!(
        name: "R.H",
        company_id: company_matriz.id
      )

      ti_shopping = Department.create!(
        name: "T.I",
        company_id: company_shopping.id
      )

      rh_shopping = Department.create!(
        name: "R.H",
        company_id: company_shopping.id
      )

      puts "Departaments cadastrados"

      #################################################

      puts "Cadastrando Sectors.."
      
      rh_shopping_administrativo = Sector.create!(
        name: "Administrativo",
        department_id: rh_shopping.id
      )

      rh_matriz_administrativo = Sector.create!(
        name: "Administrativo",
        department_id: rh_matriz.id
      )

      puts "Setores cadastrados"

      #################################################

      puts "Cadastrando Employees"

      administrador = Employee.create!(
        name: "Administrador",
        cpf: Faker::Number.number(digits: 11),
        born: Faker::Date.birthday(min_age: 18, max_age: 65),
        email: "admin@nilo.com",
        street: Faker::Address.street_name,
        number: Faker::Number.number(digits: 2),
        district: Faker::Nation.capital_city,
        city: Faker::Address.city,
        uf: Faker::Address.state_abbr,
        cep: Faker::Number.number(digits: 8),
        company_id: company_matriz.id,
        department_id: rh_matriz.id,
        sector_id: rh_matriz_administrativo.id
      )

      master = Employee.create!(
        name: "Master",
        cpf: Faker::Number.number(digits: 11),
        born: Faker::Date.birthday(min_age: 18, max_age: 65),
        email: "master@nilo.com",
        street: Faker::Address.street_name,
        number: Faker::Number.number(digits: 2),
        district: Faker::Nation.capital_city,
        city: Faker::Address.city,
        uf: Faker::Address.state_abbr,
        cep: Faker::Number.number(digits: 8),
        company_id: company_shopping.id,
        department_id: rh_shopping.id,
        sector_id: rh_shopping_administrativo.id
      )

      phill = Employee.create!(
        name: "Phill",
        cpf: Faker::Number.number(digits: 11),
        born: Faker::Date.birthday(min_age: 18, max_age: 65),
        email: "phill@nilo.com",
        street: Faker::Address.street_name,
        number: Faker::Number.number(digits: 2),
        district: Faker::Nation.capital_city,
        city: Faker::Address.city,
        uf: Faker::Address.state_abbr,
        cep: Faker::Number.number(digits: 8),
        company_id: company_shopping.id,
        department_id: rh_shopping.id,
        sector_id: rh_shopping_administrativo.id
      )

      suki = Employee.create!(
        name: "Suki",
        cpf: Faker::Number.number(digits: 11),
        born: Faker::Date.birthday(min_age: 18, max_age: 65),
        email: "suki@nilo.com",
        street: Faker::Address.street_name,
        number: Faker::Number.number(digits: 2),
        district: Faker::Nation.capital_city,
        city: Faker::Address.city,
        uf: Faker::Address.state_abbr,
        cep: Faker::Number.number(digits: 8),
        company_id: company_shopping.id,
        department_id: ti_shopping.id
      )      
      
      debora = Employee.create!(
        name: "debora",
        cpf: Faker::Number.number(digits: 11),
        born: Faker::Date.birthday(min_age: 18, max_age: 65),
        email: "debora@nilo.com",
        street: Faker::Address.street_name,
        number: Faker::Number.number(digits: 2),
        district: Faker::Nation.capital_city,
        city: Faker::Address.city,
        uf: Faker::Address.state_abbr,
        cep: Faker::Number.number(digits: 8),
        company_id: company_matriz.id,
        department_id: rh_matriz.id,
        sector_id: rh_matriz_administrativo.id
      )


      puts "Tickets cadastrados com sucesso!"

      ###############################################33

      puts "Cadastrando User para Employees"

      User.create!(
        email: "admin@nilo.com",
        password: "123456", 
        password_confirmation: "123456",
        employee: administrador,
        admin: true
      )

      User.create!(
        email: "master@nilo.com",
        password: "123456", 
        password_confirmation: "123456",
        employee: master,
        master: true
      )

      User.create!(
        email: "phill@nilo.com",
        password: "123456", 
        password_confirmation: "123456",
        employee: phill
      )

      User.create!(
        email: "suki@nilo.com",
        password: "123456", 
        password_confirmation: "123456",
        employee: suki
      )

      User.create!(
        email: "debora@nilo.com",
        password: "123456", 
        password_confirmation: "123456",
        employee: debora
      )
      
      puts "Users cadastrados com sucesso!"

      #################################################

      puts "Cadastrando Status..."

      statuses = %w(aberto concluído aguardando_aprovação)

      ActiveRecord::Base.transaction do
        statuses.each do |status|
          TicketStatus.create!(
            status: status
          )
        end
      end

      puts "Status cadastradas com sucesso!"

      ###############################################33


      puts "Cadastrando Types..."

      types = %w(manutensão instalação assistencia)

      ActiveRecord::Base.transaction do
        types.each do |type|
          TicketType.create!(
            name: type.upcase
          )
        end
      end

      puts "Types cadastradas com sucesso!"

      ###############################################33


      puts "Cadastrando Priorities..."

      priorities = %w(plan important urgent)

      ActiveRecord::Base.transaction do
        priorities.each do |priority|
          Priority.create!(
            nivel: priority
          )
        end
      end

      puts "Priorities cadastradas com sucesso!"

      ###############################################33

      puts "Cadastrando Tickets..."

      4.times do |i|
        department = nil
        company = Company.all.sample
        department = company.departments.all.sample.id if company.departments.exists?
        Ticket.create!(
          title: Faker::Lorem.sentence(word_count: 3),
          body: Faker::Lorem.paragraph(sentence_count: 2),
          conclude_at: Faker::Date.birthday(min_age: 18, max_age: 65),
          company_id: company.id,
          department_id: department,
          ticket_status_id: TicketStatus.all.sample.id,
          ticket_type_id: TicketType.all.sample.id,
          employee_id: Employee.all.sample.id,
          priority_id: Priority.all.sample.id
        )
      end

      puts "Tickets cadastrados com sucesso!"

      #################################################

      puts "Vinculando employees com tickets como responsavies"

      employees = Employee.select(:id).distinct
      
      employees.each_with_index do |e, index|
        responsible = Responsible.create!(
          employee_id: e.id,
          ticket_id: Ticket.all.sample.id
        )
      end

      puts "Tickets cadastrados com sucesso!"

      #################################################

      puts "Cadastrando Comments"

      Ticket.all.each do |ticket|
        Random.rand(5).times do
          comment = Comment.create!(
            body: Faker::Lorem.paragraph(sentence_count: 2),
            employee_id: Employee.all.sample.id,
            ticket_id: Ticket.all.sample.id
          )
        end
      end

      puts "Comments cadastrados com sucesso!"

    
    end

  end

end
