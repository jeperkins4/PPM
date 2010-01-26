Hash.class_eval do
  def split_into(divisions, &block)
    count = 0
    inject([]) do |final, key_value|
      if !block_given? || yield(key_value[0], key_value[1])
        final[count%divisions] ||= HashWithIndifferentAccess.new
        final[count%divisions].merge!({key_value[0] => key_value[1]})
        count += 1
      end
      final
    end
  end
  def remove_blanks_in_arrays
    inject(HashWithIndifferentAccess.new) do |clean_options, dirty_option|
      if dirty_option[1].instance_of?Array
        dirty_option[1].reject! {|value| value.blank? }
        clean_options.merge!({dirty_option[0] => dirty_option[1]}) unless dirty_option[1].empty?
      else
        clean_options.merge!({dirty_option[0] => dirty_option[1]})
      end
      clean_options
    end
  end

end
