package bestbank.loan;

import bestbank.passbook.Passbook;
import bestbank.passbook.PassbookDAO;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.ArrayList;

@Controller
public class LoanController {

    @GetMapping("/loans")
    public String view(String name, Model model) {
        return "loan";
    }

    @GetMapping("/loans/payments/{loanNo}")
    public String getPaymentsForLoan(@PathVariable(value="loanNo") String loanNo, Model model) {
        // Checks if Loan Number Exists
        LoanDAO loanDAO = new LoanDAO();
        if (loanDAO.isValidLoanNo(loanNo)) {
            model.addAttribute("loan", loanNo);
            // Create Loan
            double loanPrincipal = loanDAO.getLoanPrincipal(loanNo);
            String loanDate = loanDAO.getLoanDateTaken(loanNo);
            Loan loan = new Loan(loanNo, loanPrincipal, loanDate);
            loan.setPayments(loanDAO.getPayments(loanNo));
            loan.processPayments();
            // Send to Template
            model.addAttribute("loanPrincipal", loan.getProcessedPrincipal());
            model.addAttribute("loanDate", loanDate);
            model.addAttribute("payments", loan.getProcessedPayments());
        } else {
            model.addAttribute("error", "Loan No: \"" + loanNo + "\" was not found! Please try another 9-digit loan number.");
        }
        loanDAO.close();
        return "loan";
    }

    @PostMapping("/loans/payments")
    public String getPaymentsForLoanNo(@RequestParam(value="loanNo") String loanNo, Model model) {
        // Checks if Loan Number Exists
        LoanDAO loanDAO = new LoanDAO();
        if (loanDAO.isValidLoanNo(loanNo)) {
            model.addAttribute("loan", loanNo);
            // Create Loan
            double loanPrincipal = loanDAO.getLoanPrincipal(loanNo);
            String loanDate = loanDAO.getLoanDateTaken(loanNo);
            Loan loan = new Loan(loanNo, loanPrincipal, loanDate);
            loan.setPayments(loanDAO.getPayments(loanNo));
            loan.processPayments();
            // Send to Template
            model.addAttribute("loanPrincipal", loan.getProcessedPrincipal());
            model.addAttribute("loanDate", loanDate);
            model.addAttribute("payments", loan.getProcessedPayments());
        } else {
            model.addAttribute("error", "Loan No: \"" + loanNo + "\" was not found! Please try another 9-digit loan number.");
        }
        loanDAO.close();
        return "loan";
}

    @PostMapping("/loans/customer")
    public String getCustomerLoans(@RequestParam(name="firstName") String firstName, @RequestParam(name="lastName") String lastName, Model model) {
        // Gets all customer accounts
        LoanDAO loanDAO = new LoanDAO();
        if (loanDAO.isValidCustomerName(firstName, lastName)) {
            model.addAttribute("has_loan", true);
            ArrayList<String[]> listOfLoans = loanDAO.getCustomerLoans(firstName, lastName);
            model.addAttribute("loans", listOfLoans);
        } else {
            model.addAttribute("error", "Customer with First Name: \"" + firstName + "\" and Last Name: \"" + lastName + "\" was not found!");
        }
        loanDAO.close();
        return "loan";
    }

}
