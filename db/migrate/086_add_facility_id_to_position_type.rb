class AddFacilityIdToPositionType < ActiveRecord::Migration
  def self.up
    add_column :position_types, :facility_id, :integer

    Facility.find(:all).each { |facility| self.create_facility_positions(facility) }
    
    Position.find(:all).each { |position| self.tie_to_position_type(position) }
    
    PositionType.destroy_all('facility_id is null')
    
    remove_column :positions, :facility_id
  end

  def self.down
    
    # Note in order for the down migration to work, you'll need position_types of all attribute combinations
    # with facility_id = null
    add_column :positions, :facility_id, :integer
    Position.find(:all).each { |position| self.untie_to_position_type(position) }
    PositionType.destroy_all('facility_id is not null')
    remove_column :position_types, :facility_id
  end
  
  def self.create_facility_positions(facility)
    PositionType.find(:all, :conditions => 'facility_id is null').each do |position_type|
      new_attributes = position_type.attributes.reject {|key, value| key == 'id'}
      new_attributes['facility_id'] = facility.id
      PositionType.create!(new_attributes)
    end
  end
  
  def self.tie_to_position_type(position)
    position_type_attrs = position.position_type.attributes.reject {|key, value| key == 'id'}
    position_type_attrs['facility_id'] = position.facility_id
    position_type_attrs.symbolize_keys!
    new_position_type_id = PositionType.find(:first, :conditions => position_type_attrs).id
    position.update_attribute(:position_type_id, new_position_type_id)
  end

  def self.untie_to_position_type(position)
    new_facility_id = position.position_type.facility_id
    new_position_type_attributes = position.position_type.attributes.reject {|key,value| key == 'id'}
    new_position_type_attributes['facility_id'] = nil
    new_position_type_id = PositionType.find(:first, :conditions => new_position_type_attributes.symbolize_keys).id
    position.update_attributes({:facility_id => new_facility_id, :position_type_id => new_position_type_id})
  end
end
