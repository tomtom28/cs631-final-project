package bestbank.transaction;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class TransactionController {

    @GetMapping("/transactions")
    public String view(String name) {
        return "transaction";
    }


//    @GetMapping("/transactions/receipt/{loanNo}/{paymentNo}")
//    public String viewLoanPayment(String name) {
//        return "loan";
//    }
//
//    @GetMapping("/transactions/receipt/{accountNo}/{recordNo}")
//    public String viewAccountTransaction(String name) {
//        return "account";
//    }




}
