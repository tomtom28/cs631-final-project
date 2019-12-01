$(document).ready(function() {

  // Unhide Savings Rate
  $('#radio-btn-savings').on("click", function(){
    $("#addCustomerSavingsInterest").val("2.0");
    $("#interest-rate-box").removeClass("hidden");
  });

  // Hide Savings Rate
  $('#radio-btn-checking').on("click", function(){
    $("#addCustomerSavingsInterest").val("");
    $("#interest-rate-box").addClass("hidden");
  });

});