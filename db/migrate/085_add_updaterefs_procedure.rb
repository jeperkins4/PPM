class AddUpdaterefsProcedure < ActiveRecord::Migration
  def self.up
    #sql_directory = File.join(File.dirname(__FILE__), "procedures" )
    
    # Hack: Invoke database cmd tool subprocess to create our mysql stored procedure.
    #conf = ActiveRecord::Base.configurations[RAILS_ENV]
    #sql_file = File.join(sql_directory, "create_updaterefs_procedure.sql")
    #cmd_line="mysql -h "+conf["host"]+" -D "+conf["database"]+ " -u "+conf["username"]+" -p"+conf["password"]+" <"+sql_file
    #if !system(cmd_line)
    #  raise Exception, "Error executing "+cmd_line
    #end
    
  end
  
  def self.down
    #execute "DROP PROCEDURE my_stored_procedure"
  end
  
end
