$(document).ready(function() {

    // Click Listener
    $('.select-loan').on("click", function(){
        var loanNo = $(this).data('loan');
        // Redirect to new page
        window.location = '/loans/payments/' + loanNo;
    });

});