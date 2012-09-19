Array.class_eval do

  #Since we don't have Ruby 1.8.7 yet,
  #this does the same as Hash[some_array]
  def to_hash
    inject({}) {|memo, array| {array[0] => array[1]}.merge(memo) }
  end

end
