module Userstamped
  # Invoked when "include Userstamped" is called in base_class.
  def self.append_features(base_class)
    base_class.before_create { |model| model.created_by = User.current_user }
    base_class.before_save   { |model| model.updated_by = User.current_user }
  end
end
