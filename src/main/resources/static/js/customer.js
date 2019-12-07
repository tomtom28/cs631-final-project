$(document).ready(function() {

  // Unhide Savings Rate
  $('#radio-btn-savings').on("click", function(){
    $("#customerInterestOrOverdraft").val("2.0");
    $("#interestOrOverdraft").html("Interest Rate (%)");
  });

  // Hide Savings Rate
  $('#radio-btn-checking').on("click", function(){
    $("#customerInterestOrOverdraft").val("0.00");
    $("#interestOrOverdraft").html("Overdraft Amount ($)");
  });

});