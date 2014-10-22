require 'active_support/inflector'
module Models
  def save
    col_name_list = self.instance_variables.map(&:to_s).map { |var| var.gsub("@","") }.select { |var| var != 'id' }
    var_to_pass_in = col_name_list.map do |var|
      self.instance_variable_get("@#{var}")
    end
    sql_value = []
    var_to_pass_in.count.times do
      sql_value << "?"
    end
    
    if @id.nil?
      query = <<-SQL 
      INSERT INTO 
        #{File.basename(table_name, ".rb").pluralize} (#{col_name_list.join(",")})
      VALUES 
        (#{sql_value.join(",")})
      SQL
      
      QuestionsDB.instance.execute(query, *var_to_pass_in)
      @id = QuestionsDB.instance.last_insert_row_id
    else
      update
    end
  end
  
  def update
    col_name_list = self.instance_variables.map(&:to_s).map { |var| var.gsub("@","") }.select { |var| var != 'id' }
    col_list = col_name_list.map do |col_name|
      "#{col_name} = ?"
    end
    
    var_to_pass_in = self.instance_variables.map(&:to_s).map do |var|
      self.instance_variable_get(var)
    end
    
    query = <<-SQL
    UPDATE 
      #{table_name}
    SET 
      #{col_list.join(",")}
    WHERE id = ?
    SQL
    
    QuestionsDB.instance.execute(query, *var_to_pass_in)
  end
  
end