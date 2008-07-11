module ActiveRecord
  module ForceUppercase
    def self.append_features(base)
      super
      base.extend(ClassMethods)
    end
    
    module ClassMethods
      def force_uppercase(options = {})
        all_string_columns = self.columns.select { |c| c.type == :string }
        all_text_columns = self.columns.select { |c| c.type == :text }
      
        if options[:include_text]
          all_possible_columns = all_string_columns | all_text_columns
        else
          all_possible_columns = all_string_columns
        end
      
        columns_to_convert = Array.new
        if options[:only]
          options[:only] = [options[:only]] unless options[:only].is_a?(Array)
        
          options[:only].each do | inc_col |
            col = all_possible_columns.detect { |c| c.name == inc_col.to_s }
            columns_to_convert << col if col
          end
        else
          columns_to_convert = all_possible_columns
        end
      
        if options[:except]
          options[:except] = [options[:except]] unless options[:except].is_a?(Array)
        
          options[:except].each do | exc_col |
            columns_to_convert.delete_if { |c| c.name == exc_col.to_s }
          end
        end
        
        columns_to_convert = columns_to_convert.collect { |c| c.name }.join("|")
        
        class_eval <<-EOV
          include ActiveRecord::ForceUppercase::InstanceMethods
          
          def columns_to_convert_to_uppercase
            \"#{columns_to_convert}\"
          end
          
          before_save :convert_strings_to_uppercase
        EOV
      end
    end
      
    module InstanceMethods
      private
      
      def convert_strings_to_uppercase
        columns_to_convert = columns_to_convert_to_uppercase
        
        columns_to_convert.split("|").each { |name| self[name].upcase! if self[name] } if columns_to_convert
      end
    end
  end
end

ActiveRecord::Base.class_eval do 
  include ActiveRecord::ForceUppercase
end