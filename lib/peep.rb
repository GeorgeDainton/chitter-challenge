require 'pg'

class Peep
  def self.all
    if ENV['ENVIRONMENT'] == 'test'
      connection = PG.connect(dbname: 'chitter_test')
    else 
      connection = PG.connect(dbname: 'chitter')
    end
    
    result = connection.exec("SELECT * FROM peeps;")
    result.map {|peep| peep['created_at'] + ' ----- ' + peep['content']}.reverse
  end

  def self.new(content:)
    if ENV['ENVIRONMENT'] == 'test'
      connection = PG.connect(dbname: 'chitter_test')
    else 
      connection = PG.connect(dbname: 'chitter')
    end

    connection.exec("INSERT INTO peeps (content) VALUES('#{content}')")
  end 
end 
