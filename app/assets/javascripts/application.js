// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery3
//= require jquery_ujs
//= require_tree .

// $(document).ready(function(){
//   $('[js-search-bar]').change(function(event) {})

// }
$(document).ready(function () {
  $('#search').on('keyup',function (event) {
    search_term = $(this).val();
    $.ajax({
      type: 'GET',
      url: '/api/v1/search?' + "api_key=c28070e54002a91b67db2089b53a51f4&q=" + search_term,
      success: function(data) {
        $('.dropDown').remove();
        $('#searchbar').append("<select class=dropDown></select>");
        data.forEach(function(book) {
          $(".dropDown").append("<option>" + book.title + "</option>");
        })
      }
    })
  });
});