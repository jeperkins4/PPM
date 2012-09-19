//= require jquery
//= require jquery_ujs
//= require dataTables/jquery.dataTables
//= require dataTables/jquery.dataTables.bootstrap
//= require dataTables/extras/FixedColumns
//= require bootstrap
//= require bootstrap-datepicker
//= require_tree .

$ -> 
  $('.dropdown-toggle').dropdown
  $("div.alert").fadeOut 3000
