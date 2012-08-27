# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user_type do
    user_type "MyString"
    description "MyString"
    access_level_id 1
  end
end
