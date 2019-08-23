namespace :dev do
  desc "Configura o ambiente de desenvolvimento"
    
  task setup: :environment do

    puts "Resetando o banco de dados"
    
    %x(rails db:drop db:create db:migrate)

    puts "Cadastrando Companies..."

    companies = %w(Geral Matriz Shopping Posto Atacadão)

    companies.each do |company|
      Company.create!(
        name: company
      )
    end

    puts "Companies cadastradas com sucesso!"

    puts "Cadastrando Tickets..."

    100.times do |i|
      Ticket.create!(
        title: Faker::Lorem.sentence(3),
        body: Faker::Lorem.paragraph(2, false, 4),
        conclude_at: Faker::Date.between(20.days.ago, 30.days.from_now),
        company_id: Company.all.sample.id
      )
    end

    puts "Tickets cadastrados com sucesso!"   

  end

end
