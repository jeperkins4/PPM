class MoveEvidenceToNotes < ActiveRecord::Migration
  def self.up
    PppamsReview.all.each do |review|
      review.notes = "#{review.notes} \n \n #{review.evidence}"
    end
    remove_column :pppams_reviews, :evidence
  end

  def self.down
    add_column :pppams_reviews, :evidence, :text
  end
end
