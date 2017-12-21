// This is a manifest file that'll be compiled into application.js, which will include all the files
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
// app/assets/javascripts/application.js
//
//= require Chart.min
//= require rails-ujs
//= require jquery3
//= require popper
//= require bootstrap-sprockets
//= require_tree .
//= require_tree ./channels
//= require jquery-ui

$(() => suhDudes());

$(() => {
  $('#live-search').on('keyup', function() {
    searchValue = $(this).val()
    fetch(`/api/v1/search?type=items&q=${searchValue}&api_key=ac7ce348bf0dec19019d00e6a66dac86df7ab51aed6f9ec92ddb0bb196c9d220aba24221f37ddd6bedb62bda0f6570284ff45a004db78fa0a64875975be161ce`)
    .then(response => response.json())
    .then(json => suggest(json))
  })
})

const suggest = (json) => {
  $('#live-search').autocomplete({
    source: formatTitles(json.results),
    source: formatDescription(json.results)
  })
}

const formatTitles      = results => { return results.map(book => book.title) }
const formatDescription = results => { return results.map(book => book.description) }

const suhDudes = () => {
  console.log('suh dude!');
}