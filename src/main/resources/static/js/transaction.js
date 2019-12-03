$(document).ready(function() {

  // Click Listener
  $('#cancelWithdrawBtn').on("click", function(){
    // Redirect to back to same page (refresh)
    window.location = '/transactions';
    return false;
  });

  // View Account Balance API Query
  $('#viewBalanceBtn').on("click", function(){
    // Validate input
    var accountNo = $("#cashViewAccoutNo").val();
    if (accountNo == "") {
      return true;
    }
    // API call to query DB
    $.ajax({
      url: '/api/transactions/balance/account/' + accountNo
    }).done(function(response){
      console.log(response);
      // Handle error, or proceed
      if(response.error) {
        var message = "Error! Could Not View Account Balance: \n" +
            response.error;
        alert(message);
      }
      else {
        // Add values to form
        $("#cashWithdrawAccoutNo").val(response.accountNo);
        $("#cashWithdrawBalance").val(response.balance);
        // Unhide Form
        $("#cashWithdrawForm").removeClass("hidden");
      }
    });
    return false;
  });
});