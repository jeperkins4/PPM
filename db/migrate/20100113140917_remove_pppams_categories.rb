class RemovePppamsCategories < ActiveRecord::Migration
  def self.up
    add_column :pppams_indicators, :facility_id, :integer

    PppamsIndicator.find(:all, :include => :pppams_category).each do |indicator|
      indicator.update_attribute(:facility_id, indicator.pppams_category.facility_id)
      indicator.update_attribute(:created_on, Date.new(2008,1,1))
    end

    drop_table :pppams_categories

    remove_column :pppams_indicators, :pppams_category_id
    remove_column :pppams_indicators, :question
    add_column    :pppams_indicators, :active_on, :date
    change_column_default :pppams_indicators, :start_month, 1
    change_column_default :pppams_indicators, :good_months, ":1:"
    change_column_default :pppams_indicators, :frequency, 1
  end

  def self.down
    add_column :pppams_indicators, :pppams_category_id
    create_table :pppams_categories do |t|
      t.references :facility
      t.references :pppams_indicator_base_ref
      t.string :name
      # t.text :description   => description was never used.
    end
    PppamsCategoryBaseRef.find(:all, :include => [:pppams_indicator_base_refs]).each do |category_base|
      Facility.all.each do |facility|
        new_category = PppamsCategory.create(:facility_id => facility.id,
                              :pppams_category_base_ref_id => category_base.id,
                              :name => category_base.name)
        PppamsIndicators.find(:all, :conditions => {:facility => facility,
                                                    :pppams_category => {
                                                      :pppams_category_base_ref => category_base
                                                    }
                                                   }
                             ).each do |facility_indicator|
          facility_indicator.update_attribute(:pppams_category_id, new_category.id)
        end
      end
      remove_column :pppams_indicators, :facility_id
    end
  end
end
