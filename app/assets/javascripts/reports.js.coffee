# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
$ ->
  $(".datepicker").datepicker 
  if $("#report_name").val() is ""
    $("#report_use_date").parent().parent().hide()
    $("#report_start_date_1i").parent().parent().hide()
    $("#report_end_date_1i").parent().parent().hide()
    $("#report_status").parent().parent().hide()
    $("#report_mins_number").parent().parent().hide()
    $("#report_incident_type_id").parent().parent().hide()
    $("#report_issue_number").parent().parent().hide()
    $("#report_category").parent().parent().hide()
    $("#report_pppams_issue_number").parent().parent().hide()

  $('#report_use_date').change -> 
    if $("#report_use_date").val() is "Yes"
      $("#report_start_date_1i").parent().parent().show()
      $("#report_end_date_1i").parent().parent().show()
    else
      $("#report_start_date_1i").parent().parent().hide()
      $("#report_end_date_1i").parent().parent().hide()

  $('#report_name').change -> 
    if $("#report_name").val() is ""
      $("#report_use_date").parent().parent().hide()
      $("#report_status").parent().parent().hide()
      $("#report_mins_number").parent().parent().hide()
      $("#report_start_date_1i").parent().parent().hide()
      $("#report_end_date_1i").parent().parent().hide()
      $("#report_incident_type_id").parent().parent().hide()
      $("#report_issue_number").parent().parent().hide()
      $("#report_category").parent().parent().hide()
      $("#report_pppams_issue_number").parent().parent().hide()
    else if $("#report_name").val() is "Incident"
      $("#report_use_date").parent().parent().show()
      $("#report_status").parent().parent().show()
      $("#report_mins_number").parent().parent().show()
      $("#report_incident_type_id").parent().parent().show()
      $("#report_issue_number").parent().parent().hide()
      $("#report_category").parent().parent().hide()
      $("#report_pppams_issue_number").parent().parent().hide()
    else if $("#report_name").val() is "Non Comp Issue"
      $("#report_use_date").parent().parent().show()
      $("#report_status").parent().parent().show()
      $("#report_issue_number").parent().parent().show()
      $("#report_mins_number").parent().parent().hide()
      $("#report_incident_type_id").parent().parent().hide()
      $("#report_category").parent().parent().hide()
      $("#report_pppams_issue_number").parent().parent().hide()
    else if $("#report_name").val() is "Pppams Issue"
      $("#report_use_date").parent().parent().show()
      $("#report_status").parent().parent().show()
      $("#report_pppams_issue_number").parent().parent().show()
      $("#report_category").parent().parent().show()
      $("#report_mins_number").parent().parent().hide()
      $("#report_issue_number").parent().parent().hide()
      $("#report_incident_type_id").parent().parent().hide()
    else
      $("#report_use_date").parent().parent().show()
      $("#report_status").parent().parent().hide()
      $("#report_mins_number").parent().parent().hide()
      $("#report_incident_type_id").parent().parent().hide()
      $("#report_issue_number").parent().parent().hide()
      $("#report_category").parent().parent().hide()
      $("#report_pppams_issue_number").parent().parent().hide()


  #$(".dataTable").each ->
  #  oTable = $(".dataTable").dataTable(
  #    sDom: "<'row-fluid'<'span6'l><'span6'f>r>t<'row-fluid'<'span6'i><'span6'p>>"
  #    sPaginationType: "bootstrap"
  #    sScrollX: "880px"
  #    #bScrollCollapse: true
  #  )

 #   new FixedColumns(oTable,
 #     iLeftColumns: 1
 #     iLeftWidth: 110
 #     iRightColumns: 2
 #     iRightWidth: 150
 #   )

  popTable = $("#population").dataTable(
    sDom: "<'row-fluid'<'span6'l><'span6'f>r>t<'row-fluid'<'span6'i><'span6'p>>"
    sPaginationType: "bootstrap"
    sScrollX: "880px"
    #bScrollCollapse: true
  )

  new FixedColumns(popTable,
    iLeftColumns: 1
    iLeftWidth: 110
    iRightColumns: 2
    iRightWidth: 150
  )

  ethTable = $("#ethnicity").dataTable(
    sDom: "<'row-fluid'<'span6'l><'span6'f>r>t<'row-fluid'<'span6'i><'span6'p>>"
    sPaginationType: "bootstrap"
    sScrollX: "880px"
    #bScrollCollapse: true
  )

  new FixedColumns(ethTable,
    iLeftColumns: 1
    iLeftWidth: 110
    iRightColumns: 2
    iRightWidth: 150
  )

  cusTable = $("#custody").dataTable(
    sDom: "<'row-fluid'<'span6'l><'span6'f>r>t<'row-fluid'<'span6'i><'span6'p>>"
    sPaginationType: "bootstrap"
    sScrollX: "880px"
    #bScrollCollapse: true
  )

  new FixedColumns(cusTable,
    iLeftColumns: 1
    iLeftWidth: 110
    iRightColumns: 2
    iRightWidth: 150
  )

  xferTable = $("#transfers").dataTable(
    sDom: "<'row-fluid'<'span6'l><'span6'f>r>t<'row-fluid'<'span6'i><'span6'p>>"
    sPaginationType: "bootstrap"
    sScrollX: "880px"
    #bScrollCollapse: true
  )

  new FixedColumns(xferTable,
    iLeftColumns: 1
    iLeftWidth: 110
    iRightColumns: 2
    iRightWidth: 150
  )

  disTable = $("#discharges").dataTable(
    sDom: "<'row-fluid'<'span6'l><'span6'f>r>t<'row-fluid'<'span6'i><'span6'p>>"
    sPaginationType: "bootstrap"
    sScrollX: "880px"
    #bScrollCollapse: true
  )

  new FixedColumns(disTable,
    iLeftColumns: 1
    iLeftWidth: 110
    iRightColumns: 2
    iRightWidth: 150
  )

  confTable = $("#confinements").dataTable(
    sDom: "<'row-fluid'<'span6'l><'span6'f>r>t<'row-fluid'<'span6'i><'span6'p>>"
    sPaginationType: "bootstrap"
    sScrollX: "880px"
    #bScrollCollapse: true
  )

  new FixedColumns(confTable,
    iLeftColumns: 1
    iLeftWidth: 110
    iRightColumns: 2
    iRightWidth: 150
  )

  dscTable = $("#disciplinary").dataTable(
    sDom: "<'row-fluid'<'span6'l><'span6'f>r>t<'row-fluid'<'span6'i><'span6'p>>"
    sPaginationType: "bootstrap"
    sScrollX: "880px"
    #bScrollCollapse: true
  )

  new FixedColumns(dscTable,
    iLeftColumns: 1
    iLeftWidth: 110
    iRightColumns: 2
    iRightWidth: 150
  )

  asgTable = $("#assignment").dataTable(
    sDom: "<'row-fluid'<'span6'l><'span6'f>r>t<'row-fluid'<'span6'i><'span6'p>>"
    sPaginationType: "bootstrap"
    sScrollX: "880px"
    #bScrollCollapse: true
  )

  new FixedColumns(asgTable,
    iLeftColumns: 1
    iLeftWidth: 110
    iRightColumns: 2
    iRightWidth: 150
  )

  libTable = $("#library").dataTable(
    sDom: "<'row-fluid'<'span6'l><'span6'f>r>t<'row-fluid'<'span6'i><'span6'p>>"
    sPaginationType: "bootstrap"
    sScrollX: "880px"
    #bScrollCollapse: true
  )

  new FixedColumns(libTable,
    iLeftColumns: 1
    iLeftWidth: 110
    iRightColumns: 2
    iRightWidth: 150
  )

  crtTable = $("#courts").dataTable(
    sDom: "<'row-fluid'<'span6'l><'span6'f>r>t<'row-fluid'<'span6'i><'span6'p>>"
    sPaginationType: "bootstrap"
    sScrollX: "880px"
    #bScrollCollapse: true
  )

  new FixedColumns(crtTable,
    iLeftColumns: 1
    iLeftWidth: 110
    iRightColumns: 2
    iRightWidth: 150
  )

  acaTable = $("#academic").dataTable(
    sDom: "<'row-fluid'<'span6'l><'span6'f>r>t<'row-fluid'<'span6'i><'span6'p>>"
    sPaginationType: "bootstrap"
    sScrollX: "880px"
    #bScrollCollapse: true
  )

  new FixedColumns(acaTable,
    iLeftColumns: 1
    iLeftWidth: 110
    iRightColumns: 2
    iRightWidth: 150
  )

  eduTable = $("#education").dataTable(
    sDom: "<'row-fluid'<'span6'l><'span6'f>r>t<'row-fluid'<'span6'i><'span6'p>>"
    sPaginationType: "bootstrap"
    sScrollX: "880px"
    #bScrollCollapse: true
  )

  new FixedColumns(eduTable,
    iLeftColumns: 1
    iLeftWidth: 110
    iRightColumns: 2
    iRightWidth: 150
  )

  subTable = $("#substance").dataTable(
    sDom: "<'row-fluid'<'span6'l><'span6'f>r>t<'row-fluid'<'span6'i><'span6'p>>"
    sPaginationType: "bootstrap"
    sScrollX: "880px"
    #bScrollCollapse: true
  )

  new FixedColumns(subTable,
    iLeftColumns: 1
    iLeftWidth: 110
    iRightColumns: 2
    iRightWidth: 150
  )

  abuTable = $("#abuse").dataTable(
    sDom: "<'row-fluid'<'span6'l><'span6'f>r>t<'row-fluid'<'span6'i><'span6'p>>"
    sPaginationType: "bootstrap"
    sScrollX: "880px"
    #bScrollCollapse: true
  )

  new FixedColumns(abuTable,
    iLeftColumns: 1
    iLeftWidth: 110
    iRightColumns: 2
    iRightWidth: 150
  )

  hltTable = $("#healthcare").dataTable(
    sDom: "<'row-fluid'<'span6'l><'span6'f>r>t<'row-fluid'<'span6'i><'span6'p>>"
    sPaginationType: "bootstrap"
    sScrollX: "880px"
    #bScrollCollapse: true
  )

  new FixedColumns(hltTable,
    iLeftColumns: 1
    iLeftWidth: 110
    iRightColumns: 2
    iRightWidth: 150
  )

  medTable = $("#medical").dataTable(
    sDom: "<'row-fluid'<'span6'l><'span6'f>r>t<'row-fluid'<'span6'i><'span6'p>>"
    sPaginationType: "bootstrap"
    sScrollX: "880px"
    #bScrollCollapse: true
  )

  new FixedColumns(medTable,
    iLeftColumns: 1
    iLeftWidth: 110
    iRightColumns: 2
    iRightWidth: 150
  )

  menTable = $("#mental").dataTable(
    sDom: "<'row-fluid'<'span6'l><'span6'f>r>t<'row-fluid'<'span6'i><'span6'p>>"
    sPaginationType: "bootstrap"
    sScrollX: "880px"
    #bScrollCollapse: true
  )

  new FixedColumns(menTable,
    iLeftColumns: 1
    iLeftWidth: 110
    iRightColumns: 2
    iRightWidth: 150
  )

  grvTable = $("#grievances").dataTable(
    sDom: "<'row-fluid'<'span6'l><'span6'f>r>t<'row-fluid'<'span6'i><'span6'p>>"
    sPaginationType: "bootstrap"
    sScrollX: "880px"
    #bScrollCollapse: true
  )

  new FixedColumns(grvTable,
    iLeftColumns: 1
    iLeftWidth: 110
    iRightColumns: 2
    iRightWidth: 150
  )

  ingTable = $("#inmate_grievances").dataTable(
    sDom: "<'row-fluid'<'span6'l><'span6'f>r>t<'row-fluid'<'span6'i><'span6'p>>"
    sPaginationType: "bootstrap"
    sScrollX: "880px"
    #bScrollCollapse: true
  )

  new FixedColumns(ingTable,
    iLeftColumns: 1
    iLeftWidth: 110
    iRightColumns: 2
    iRightWidth: 150
  )

  fmsTable = $("#food_meals_served").dataTable(
    sDom: "<'row-fluid'<'span6'l><'span6'f>r>t<'row-fluid'<'span6'i><'span6'p>>"
    sPaginationType: "bootstrap"
    sScrollX: "880px"
    #bScrollCollapse: true
  )

  new FixedColumns(fmsTable,
    iLeftColumns: 1
    iLeftWidth: 110
    iRightColumns: 2
    iRightWidth: 150
  )

  frcTable = $("#food_raw_cost").dataTable(
    sDom: "<'row-fluid'<'span6'l><'span6'f>r>t<'row-fluid'<'span6'i><'span6'p>>"
    sPaginationType: "bootstrap"
    sScrollX: "880px"
    #bScrollCollapse: true
  )

  new FixedColumns(frcTable,
    iLeftColumns: 1
    iLeftWidth: 110
    iRightColumns: 2
    iRightWidth: 150
  )

  rinTable = $("#religious_inmates").dataTable(
    sDom: "<'row-fluid'<'span6'l><'span6'f>r>t<'row-fluid'<'span6'i><'span6'p>>"
    sPaginationType: "bootstrap"
    sScrollX: "880px"
    #bScrollCollapse: true
  )

  new FixedColumns(rinTable,
    iLeftColumns: 1
    iLeftWidth: 110
    iRightColumns: 2
    iRightWidth: 150
  )

  rhrTable = $("#religious_hours").dataTable(
    sDom: "<'row-fluid'<'span6'l><'span6'f>r>t<'row-fluid'<'span6'i><'span6'p>>"
    sPaginationType: "bootstrap"
    sScrollX: "880px"
    #bScrollCollapse: true
  )

  new FixedColumns(rhrTable,
    iLeftColumns: 1
    iLeftWidth: 110
    iRightColumns: 2
    iRightWidth: 150
  )

  urnTable = $("#urinalysis").dataTable(
    sDom: "<'row-fluid'<'span6'l><'span6'f>r>t<'row-fluid'<'span6'i><'span6'p>>"
    sPaginationType: "bootstrap"
    sScrollX: "880px"
    #bScrollCollapse: true
  )

  new FixedColumns(urnTable,
    iLeftColumns: 1
    iLeftWidth: 110
    iRightColumns: 2
    iRightWidth: 150
  )

  comTable = $("#complaints").dataTable(
    sDom: "<'row-fluid'<'span6'l><'span6'f>r>t<'row-fluid'<'span6'i><'span6'p>>"
    sPaginationType: "bootstrap"
    sScrollX: "880px"
    #bScrollCollapse: true
  )

  new FixedColumns(comTable,
    iLeftColumns: 1
    iLeftWidth: 110
    iRightColumns: 2
    iRightWidth: 150
  )

  minsTable = $("#mins").dataTable(
    sDom: "<'row-fluid'<'span6'l><'span6'f>r>t<'row-fluid'<'span6'i><'span6'p>>"
    sPaginationType: "bootstrap"
    sScrollX: "880px"
    #bScrollCollapse: true
  )

  new FixedColumns(minsTable,
    iLeftColumns: 1
    iLeftWidth: 110
    iRightColumns: 2
    iRightWidth: 150
  )

  bckTable = $("#background").dataTable(
    sDom: "<'row-fluid'<'span6'l><'span6'f>r>t<'row-fluid'<'span6'i><'span6'p>>"
    sPaginationType: "bootstrap"
    sScrollX: "880px"
    #bScrollCollapse: true
  )

  new FixedColumns(bckTable,
    iLeftColumns: 1
    iLeftWidth: 110
    iRightColumns: 2
    iRightWidth: 150
  )

  dmgTable = $("#damages").dataTable(
    sDom: "<'row-fluid'<'span6'l><'span6'f>r>t<'row-fluid'<'span6'i><'span6'p>>"
    sPaginationType: "bootstrap"
    sScrollX: "880px"
    #bScrollCollapse: true
  )

  new FixedColumns(dmgTable,
    iLeftColumns: 1
    iLeftWidth: 110
    iRightColumns: 2
    iRightWidth: 150
  )

  vacTable = $("#vacancies").dataTable(
    sDom: "<'row-fluid'<'span6'l><'span6'f>r>t<'row-fluid'<'span6'i><'span6'p>>"
    sPaginationType: "bootstrap"
    sScrollX: "880px"
    #bScrollCollapse: true
  )

  new FixedColumns(vacTable,
    iLeftColumns: 1
    iLeftWidth: 110
    iRightColumns: 2
    iRightWidth: 150
  )
