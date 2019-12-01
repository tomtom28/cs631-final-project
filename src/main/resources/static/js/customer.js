$(document).ready(function() {

  // Unhide Savings Rate
  $('#radio-btn-savings').on("click", function(){
    $("#interest-rate-box").removeClass("hidden");
  });

  // Hide Savings Rate
  $('#radio-btn-checking').on("click", function(){
    $("#interest-rate-box").addClass("hidden");
  });

});