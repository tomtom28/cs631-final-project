package bestbank.transaction;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.ResponseBody;

import java.sql.SQLException;
import java.util.HashMap;

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


    @GetMapping("/api/transactions/balance/account/{accountNo}")
    @ResponseBody
    public HashMap<String,String> viewAccountBalance(@PathVariable(value="accountNo") String accountNo) {

        // REST API
        HashMap<String,String> response = new HashMap<>();

        // Get Account Balance
        TransactionDAO transactionDAO = new TransactionDAO();
        try {
            double balance = transactionDAO.getAccountBalance(accountNo);
            response.put("accountNo", accountNo);
            response.put("balance", String.format("%.2f", balance));
        } catch (SQLException e) {
            response.put("error", e.getMessage());
        }
        transactionDAO.close();
        return response;
    }


    // TODO more get/post requests to handle front end

    // TODO also need to build out "receipts" pages for the loan payment, and wd/cd transactions


}
