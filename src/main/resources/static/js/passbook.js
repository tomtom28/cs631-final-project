$(document).ready(function() {

  // Click Listener
  $('.select-account').on("click", function(){
    var accountNo = $(this).data('account');
    // Redirect to new page
    window.location = '/passbooks/account/' + accountNo;
  });

});