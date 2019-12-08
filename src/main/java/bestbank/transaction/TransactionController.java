package bestbank.transaction;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.sql.SQLException;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
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
        } finally {
            transactionDAO.close();
        }
        return response;
    }


    @PostMapping("/transactions/checks")
    public String makeCheckDeposit(@RequestParam(value="fromAccountNo") String fromAccountNo, @RequestParam(value="toAccountNo") String toAccountNo, @RequestParam(value="amount") String amountStr, Model model) {
        String actionType = "[Cheque Deposit]";
        TransactionDAO transactionDAO = new TransactionDAO();
        try {
            // Process Cheque Deposit
            double amount = Double.parseDouble(amountStr);
            transactionDAO.depositCheque(fromAccountNo, toAccountNo, amount);

            // TODO get DB date?
            // Or just assume it's today?
            DateTimeFormatter dtf = DateTimeFormatter.ofPattern("yyyy-MM-dd");
            LocalDate localDate = LocalDate.now();
            String transactionDate = dtf.format(localDate);

            // Generate Receipt (if query was successful)
            String transactionType = "Cheque Deposit";
            String receiptTitle = "Your " + transactionType + " has been processed!";
            model.addAttribute("receiptTitle", receiptTitle);
            model.addAttribute("accountNo", toAccountNo);
            model.addAttribute("date", transactionDate);
            model.addAttribute("transactionType", transactionType);
            model.addAttribute("amount", amount);

            return "receipts/account";

        } catch (Exception e) {

            // Throw Error to Transaction page (if failed)
            model.addAttribute("error","Action " + actionType + " Failed: " +
                    e.getMessage()); // message from DB
            return "transaction";

        } finally {
            transactionDAO.close();
        }

    }


    @PostMapping("/transactions/cash/withdraw")
    public String makeCashWithdrawal(@RequestParam(value="accountNo") String accountNo,  @RequestParam(value="balance") String balanceStr, @RequestParam(value="amount") String amountStr, Model model) {

        String actionType = "[Cash Withdrawal]";
        TransactionDAO transactionDAO = new TransactionDAO();

        try {
            // Savings account cannot go negative but Checking accounts might have overdraft
            double amount = Double.parseDouble(amountStr);
            double balance = Double.parseDouble(balanceStr);
            double overdraftAllowed = transactionDAO.getOverDraftAllowed(accountNo);
            if ( ((balance - amount) < 0) && (Math.abs(balance - amount) > overdraftAllowed) ) {  // negative account value & overdraft is exceeded
                // Throw Error to Transaction page (if failed)
                model.addAttribute("error","Action " + actionType + " Failed: " +
                        "Savings Account Balance or Checking Account Overdraft has been exceeded!"); // Custom message
                return "transaction";

            }

            // Process Withdrawal
            transactionDAO.makeCashWithdrawal(accountNo, amount);

            // TODO get DB date?
            // Or just assume it's today?
            DateTimeFormatter dtf = DateTimeFormatter.ofPattern("yyyy-MM-dd");
            LocalDate localDate = LocalDate.now();
            String transactionDate = dtf.format(localDate);

            // Generate Receipt (if query was successful)
            String transactionType = "Cash Withdrawal";
            String receiptTitle = "Your " + transactionType + " has been processed!";
            model.addAttribute("receiptTitle", receiptTitle);
            model.addAttribute("accountNo", accountNo);
            model.addAttribute("date", transactionDate);
            model.addAttribute("transactionType", transactionType);
            model.addAttribute("amount", amount);

            return "receipts/account";

        } catch (Exception e) {

            // Throw Error to Transaction page (if failed)
            model.addAttribute("error","Action " + actionType + " Failed: " +
                    e.getMessage()); // message from DB or DAO
            return "transaction";

        } finally {
            transactionDAO.close();
        }
    }


    @PostMapping("/transactions/cash/deposit")
    public String makeCashDeposit(@RequestParam(value="accountNo") String accountNo, @RequestParam(value="amount") String amountStr, Model model) {
        String actionType = "[Cash Deposit]";
        TransactionDAO transactionDAO = new TransactionDAO();
        try {
            // Process Deposit
            double amount = Double.parseDouble(amountStr);
            transactionDAO.makeCashDeposit(accountNo, amount);

            // TODO get DB date?
            // Or just assume it's today?
            DateTimeFormatter dtf = DateTimeFormatter.ofPattern("yyyy-MM-dd");
            LocalDate localDate = LocalDate.now();
            String transactionDate = dtf.format(localDate);


            // Generate Receipt (if query was successful)
            String transactionType = "Cash Deposit";
            String receiptTitle = "Your " + transactionType + " has been processed!";
            model.addAttribute("receiptTitle", receiptTitle);
            model.addAttribute("accountNo", accountNo);
            model.addAttribute("date", transactionDate);
            model.addAttribute("transactionType", transactionType);
            model.addAttribute("amount", amount);

            return "receipts/account";

        } catch (SQLException e) {

            // Throw Error to Transaction page (if failed)
            model.addAttribute("error","Action " + actionType + " Failed: " +
                    e.getMessage()); // message from DB
            return "transaction";

        } finally {
            transactionDAO.close();
        }

    }


    @PostMapping("/transactions/loan/payment")
    public String makeLoanPayment(@RequestParam(value="loanNo") String loanNo, @RequestParam(value="accountNo") String accountNo, @RequestParam(value="amount") String amount, Model model) {

        String actionType = "[Loan Payment]";
        TransactionDAO transactionDAO = new TransactionDAO();
        try {
            // Pay Loan
            transactionDAO.payLoan(loanNo, accountNo, amount);

            // TODO get Loan payment date?
            // Or just assume it's today?
            DateTimeFormatter dtf = DateTimeFormatter.ofPattern("yyyy-MM-dd");
            LocalDate localDate = LocalDate.now();
            String paymentDate = dtf.format(localDate);

            // Generate Receipt (if query was successful)
            model.addAttribute("loanNo", loanNo);
            model.addAttribute("paymentDate", paymentDate);
            model.addAttribute("amount", amount);

            return "receipts/loan";

        } catch (SQLException e) {

            // Throw Error to Transaction page (if failed)
            model.addAttribute("error","Action " + actionType + " Failed: " +
                    e.getMessage()); // message from DB
            return "transaction";

        } finally {
            transactionDAO.close();
        }
    }

}
