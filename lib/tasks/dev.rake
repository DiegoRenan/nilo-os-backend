namespace :dev do
  desc "Configura o ambiente de desenvolvimento"
    
  task setup: :environment do

    # puts "Resetando o banco de dados"
    
    # %x(rails db:drop db:create db:migrate)

    ###############################################33

    puts "Cadastrando Companies..."

    companies = %w(Geral Matriz Shopping Posto Atacadão)

    ActiveRecord::Base.transaction do
      companies.each do |company|
        Company.create!(
          name: company
        )
      end
    end

    puts "Companies cadastradas com sucesso!"

    ###############################################33

    puts "Cadastrando Departments..."

    100.times do |i|
      Department.create!(
        name: Faker::Commerce.department(max: 2, fixed_amount: true),
        company_id: Company.all.sample.id
      )
    end  

    puts "Departaments cadastrados"

    #################################################

    puts "Cadastrando Employees"

    Company.all.each do |company|
      Random.rand(5).times do
        employee = Employee.create!(
          name: Faker::Name.name,
          cpf: Faker::Number.number(digits: 11),
          born: Faker::Date.birthday(min_age: 18, max_age: 65),
          email: Faker::Internet.email,
          street: Faker::Address.street_name,
          number: Faker::Number.number(digits: 2),
          district: Faker::Nation.capital_city,
          city: Faker::Address.city,
          uf: Faker::Address.state_abbr,
          cep: Faker::Number.number(digits: 8),
          company_id: company.id
        )
      end
    end

    puts "Tickets cadastrados com sucesso!"

    ###############################################33

    puts "Cadastrando User para Employees"

    employees = Employee.all

    employees.each do |employee|
      User.create!(
        email: employee.email,
        password: "123456", 
        password_confirmation: "123456",
        employee: employee
      )
    end
    
    puts "Users cadastrados com sucesso!"

    #################################################

    puts "Cadastrando Tickets..."

    100.times do |i|
      Ticket.create!(
        title: Faker::Lorem.sentence(word_count: 3),
        body: Faker::Lorem.paragraph(sentence_count: 2),
        conclude_at: Faker::Date.birthday(min_age: 18, max_age: 65),
        company_id: Company.all.sample.id
      )
    end

    puts "Tickets cadastrados com sucesso!"

  end

end
