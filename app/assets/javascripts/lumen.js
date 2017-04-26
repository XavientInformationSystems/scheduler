// Lumen
// Bootswatch
//= require jquery
//= require jquery_ujs
//= require lumen/loader
//= require lumen/bootswatch
//= require moment
//= require bootstrap-datetimepicker

  
(function($, window) {
  $.fn.replaceOptions = function(options) {
    var self, $option;

    this.empty();
    self = this;

    $.each(options, function(index, option) {
      $option = $("<option></option>")
        .attr("value", option.value)
        .text(option.text);
      self.append($option);
    });
  };
})(jQuery, window);

function hide_reccurring_radios(){
	var event_type = $("select#event_occurrence option:selected").text();
	if(event_type == "Single")
		$("#reccurring-select").hide();
	else
		$("#reccurring-select").show();
}

function time_array(m, n){	
	var arr = [];
	for(var i = m; i < n; i++) {
	   arr.push({text: i, value: i});
	}
	return arr;
}

function set_frequency_reccurring_options(){
	var m = 0, n = 0;
	var select_type = $("select#frequency-reccurring-select option:selected").val();
	switch (select_type){
		case "minute-wise":
			m = 0;
			n = 60;				
			break;
		case "hour-wise":
			m = 0;
			n = 24;
			break;
		case "day-wise":
			m = 1;
			n = 32;
			break;
		case "week-wise":
			m = 1;
			n = 8;
			break;
		case "month-wise":
			m = 1;
			n = 13;
			break;
		case "year-wise":
			m = 1;
			n = 4;
			break;			
	}
	$("#frequency-reccurring-options").replaceOptions(time_array(m, n));
}


$(document).ready(function(){
	hide_reccurring_radios();
	set_frequency_reccurring_options();

	$("select").on("change",function(){
		if ($(this).attr('id') == "event_occurrence")
			hide_reccurring_radios();
		if($(this).attr('id') == "frequency-reccurring-select"){
			set_frequency_reccurring_options();
		}		
	});
})