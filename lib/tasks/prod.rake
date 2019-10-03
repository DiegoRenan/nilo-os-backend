namespace :prod do
  desc "Configura o ambiente de produção"
  task setup: :environment do
    ###############################################33
    ActiveRecord::Base.transaction do
      puts "Cadastrando Companies..."

      companies = ["AUTO POSTO NILO", "OUTROS", "BARRA CENTER SHOPPING", "ALMANAQUE", "DEPOSITO-VILA", "FILIAL", "MATRIZ"]

      
      companies.each do |company|
        Company.create!(
          name: company
        )
      end
      

      puts "Companies cadastradas com sucesso!"

      ###############################################33

      puts "Cadastrando colaborador administrador"
      company = Company.where(name: "MATRIZ").take
      employee = Employee.create!(
        name: "Administrador",
        cpf: "00000000000",
        email: "admin@nilo.com",
        cep: "00000000",
        company_id: company.id
      )

      puts "Colaborador admin cadastrados com sucesso!"

      ###############################################33

      puts "Cadastrando User para Administrador"

      employee = Employee.where(name: "Administrador").take
      User.create!(
        email: employee.email,
        password: "foobarcall", 
        password_confirmation: "foobarcall",
        admin: true,
        employee: employee
      )
      
      puts "User cadastrados com sucesso!"
  
      #################################################
      puts "Cadastrando Status..."

      statuses = %w(aberto concluído aguardando_aprovação)

      statuses.each do |status|
        TicketStatus.create!(
          status: status
        )
      end

      puts "Status cadastrados com sucesso!"

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


    end

  end

end
