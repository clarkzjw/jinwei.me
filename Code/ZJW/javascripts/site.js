(function() {
  var canvas;

  canvas = $('#processing');

  $(window).on("load", function() {
    canvas.width = window.innerWidth;
    canvas.height = window.innerHeight;
    return console.log(canvas.width, canvas.height);
  });

}).call(this);
