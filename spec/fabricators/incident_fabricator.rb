Fabricator(:incident) do
  incident_on                         "2012-08-23"
  reported_on                         "2012-08-23"
  inspector_general_on                "2012-08-23"
  description                         "MyText"
  incident_type_id                    1
  facility_id                         1
  contract_manager_notified_on        "2012-08-23"
  bureau_notified_on                  "2012-08-23"
  warden_notified_on                  "2012-08-23"
  facility_investigation_completed_on "2012-08-23"
  action_type_id                      1
  incident_type_other                 "MyString"
  incident_class_id                   1
  investigator_id                     1
  mins                                "MyString"
  action_type_other                   "MyString"
  designee_name                       "MyString"
  contract_manager_notified           false
  warden_notified                     1
  bureau_notified                     false
  facility_investigation_complete     false
  investigation_closed                false
  investigation_closed_on             "2012-08-23"
  entity_closing                      "MyString"
end
