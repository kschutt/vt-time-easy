// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
// WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
// GO AFTER THE REQUIRES BELOW.
//
//= require jquery
//= require jquery_ujs
//= require_tree .
jQuery(function(){
	    $('form').on('click', '.remove_fields', function(event) {
        $(this).prev('input[type=hidden]').val('1');
        $(this).closest('table tr').hide();
        event.preventDefault();
    });
    $('form').on('click', '.add-fields', function(event) {
        // console.log("clicked add field");
        time = new Date().getTime();
        regexp = new RegExp($(this).data('id'), 'g');
        // console.log($(this).data('fields').replace(regexp, time));
        var fieldset = $(this).data('fields').replace(regexp, time);
        var association = $(this).data('association');
        // console.log($(this).data('association'));
        // console.log(fieldset);
        // $("#" + association + "-cell table").append(fieldset);
        $("#" + association + "-cell table").first().append(fieldset);
        event.preventDefault();
    });
});