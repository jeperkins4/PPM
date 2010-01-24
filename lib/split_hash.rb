Hash.class_eval do
  def split_into(divisions, &block)
    count = 0
    inject([]) do |final, key_value|
      if !block_given? || yield(key_value[0], key_value[1])
        final[count%divisions] ||= {}
        final[count%divisions].merge!({key_value[0] => key_value[1]})
        count += 1
      end
      final
    end
  end
end
