# Place all the behaviors and hooks related to the matching controller here.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
asInitVals = new Array()
$ ->
  oTable = $('#incidents').dataTable
    sDom: "<'row-fluid'<'span6'l><'span6'f>r>t<'row-fluid'<'span6'i><'span6'p>>"
    sPaginationType: "bootstrap"
    bAutoWidth: false
    aoColumns: [{"sWidth": "55px"},{'sWidth':'70px'},{'sWidth':'70px'},{'sWidth':'70px'},{'sWidth':'70px'},{'sWidth':'90px'},{'sWidth':'40px'}]
    bProcessing: true
    bServerSide: true
    sAjaxSource: $('#incidents').data('source')

  $("tfoot input").keyup ->
    # Filter on the column (the index) of this element 
    oTable.fnFilter @value, $("tfoot input").index(this)
    
    #
    #	 * Support functions to provide a little bit of 'user friendlyness' to the textboxes in 
    #	 * the footer
    #	 
    $("tfoot input").each (i) ->
      asInitVals[i] = @value
      
    $("tfoot input").focus ->
      if @className is "search_init"
        @className = ""
        @value = ""

    $("tfoot input").blur (i) ->
      if @value is ""
        @className = "search_init span2"
        @value = asInitVals[$("tfoot input").index(this)]
