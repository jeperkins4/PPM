class PppamsReview < ActiveRecord::Base
  attr_accessible :created_by_id, :doc_count, :documentation_ref, :interview_ref, :notes, :observation_ref, :pppams_indicator_id, :real_creation_on, :score, :status, :submit_count, :updated_by_id
end
