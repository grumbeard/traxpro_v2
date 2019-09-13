//= require jquery
//= require rails-ujs
//= require_tree .
//= require ./cable.js

$(".jumbotron").css({ height: $(window).height() + "px" });

$(window).on("resize", function() {
  $(".jumbotron").css({ height: $(window).height() + "px" });
});

//= require serviceworker-companion
