	// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults

$.noConflict();
function updateMonthTab(num) {
	for (i=1;i<13;i++) {
	    tab=$('month_tab_' + i);
	    if (tab.className == 'selected') tab.className = '';
	    if (num == i) tab.className = 'selected';
	}
}

function swapselect(div) {
	inputs = div.parentNode.parentNode.getElementsByTagName("INPUT");
	for (i=0;i<inputs.length;i++) {
	    inputs[i].checked = inputs[i].checked ? false : true;
	}
}

function navslide(x) {
  if (x == '8px') {
  $('nav_hider').innerHTML = "<span>>></span>";
  $('nav_hider').href = "javascript: navslide('200px')";
  $('nav_block').style.borderLeft = '9px solid #c9c99a';
  } else {
  $('nav_hider').innerHTML = "<span><<</span>";
  $('nav_hider').href = "javascript: navslide('8px')";
  $('nav_block').style.borderLeft = 'none';
  }
  createCookie('mainmargin', x, 1);
  new Effect.Morph('main_block_content',{style:{marginLeft: x}});

}

function createCookie(name,value,days) {
	if (days) {
		var date = new Date();
		date.setTime(date.getTime()+(days*24*60*60*1000));
		var expires = "; expires="+date.toGMTString();
	}
	else var expires = "";
	document.cookie = name+"="+value+expires+"; path=/";
}

function readCookie(name) {
	var nameEQ = name + "=";
	var ca = document.cookie.split(';');
	for(var i=0;i < ca.length;i++) {
		var c = ca[i];
		while (c.charAt(0)==' ') c = c.substring(1,c.length);
		if (c.indexOf(nameEQ) == 0) return c.substring(nameEQ.length,c.length);
	}
	return null;
}

function eraseCookie(name) {
	createCookie(name,"",-1);
}

var mainmargin_preset


if (mainmargin_preset = readCookie("mainmargin")) document.write("<style>#main_block #main_block_content {margin-left:" + mainmargin_preset + "}</style>");

function fillDownInitializer() {
  jQuery('a.fill_down').live( 'click', function (eve) {
    var itemsToFill = ['frequency',
                       'start_month',
                       'active_on_1i',
                       'active_on_2i',
                       'active_on_3i',
                       'inactive_on_1i',
                       'inactive_on_2i',
                       'inactive_on_3i'
                      ];
    jQuery.each(itemsToFill, function(index, ending) {

      for(var selectorNumber=0; selectorNumber < 5; selectorNumber= selectorNumber + 1 ) {
        var aDropDownValue = dropDownValue(selectorNumber, ending);
        if(typeof(aDropDownValue) != 'undefined') {
          populate(aDropDownValue, ending);
          break;
        }
      }
    });
  });
}
function dropDownValue(integer, ending) {
  return jQuery('#pppams_indicator_base_ref_pppams_indicators_attributes_'+integer.toString()+'_'+ending).val();
}
function populate(value, ending) {
  var aDropDownOptions = jQuery('table.fill_downable').find('select[id*=_'+ending+'] option');
      aDropDownOptions.removeAttr('selected');
      aDropDownOptions.filter('[value='+value+']').attr('selected', 'selected');
}


jQuery(document).ready( function() {
    fillDownInitializer();
    scoreFilterSelecltor();
});


