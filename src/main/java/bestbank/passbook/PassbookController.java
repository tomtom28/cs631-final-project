package bestbank.passbook;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.ArrayList;

@Controller
public class PassbookController {
    @GetMapping("/passbooks")
    public String view() {
        return "passbook";
    }

    @GetMapping("/passbooks/account/{accountNo}")
    public String getPassbookForAccountNo(@PathVariable(value="accountNo") String accountNo, Model model) {
        model.addAttribute("accountNo", accountNo);
        // Checks if Account Number Exists
        PassbookDAO passbookDAO = new PassbookDAO();
        if (passbookDAO.isValidAccountNo(accountNo)) {
            model.addAttribute("account", accountNo);
            // Create Passbook
            Passbook passbook = new Passbook(accountNo);
            passbook.setTransactions(passbookDAO.getTransactions(accountNo));
            passbook.processTransactions();
            // Send to Template
            model.addAttribute("listOfCustomerSSNs", passbookDAO.getAccountCustomerSSNs(accountNo));
            model.addAttribute("transactions", passbook.getProcessedTransactions());
        } else {
            model.addAttribute("error", "Account No: \"" + accountNo + "\" was not found! Please try another 9-digit account number.");
        }
        passbookDAO.close();
        return "passbook";
    }

    @PostMapping("/passbooks/account")
    public String getPassbookForAccount(@RequestParam(name="accountNo") String accountNo, Model model) {
        // Checks if Account Number Exists
        PassbookDAO passbookDAO = new PassbookDAO();
        if (passbookDAO.isValidAccountNo(accountNo)) {
            model.addAttribute("account", accountNo);
            // Create Passbook
            Passbook passbook = new Passbook(accountNo);
            passbook.setTransactions(passbookDAO.getTransactions(accountNo));
            passbook.processTransactions();
            // Send to Template
            model.addAttribute("listOfCustomerSSNs", passbookDAO.getAccountCustomerSSNs(accountNo));
            model.addAttribute("transactions", passbook.getProcessedTransactions());
        } else {
            model.addAttribute("error", "Account No: \"" + accountNo + "\" was not found! Please try another 9-digit account number.");
        }
        passbookDAO.close();
        return "passbook";
    }

    @PostMapping("/passbooks/customer")
    public String getPassbooksCustomer(@RequestParam(name="firstName") String firstName, @RequestParam(name="lastName") String lastName, Model model) {
        // Gets all customer accounts
        PassbookDAO passbookDAO = new PassbookDAO();
        if (passbookDAO.isValidCustomerName(firstName, lastName)) {
            model.addAttribute("has_account", true);
            ArrayList<String[]> listOfAccounts = passbookDAO.getCustomerAccounts(firstName, lastName);
            model.addAttribute("accounts", listOfAccounts);
        } else {
            model.addAttribute("error", "Customer with First Name: \"" + firstName + "\" and Last Name: \"" + lastName + "\" was not found!");
        }
        passbookDAO.close();
        return "passbook";
    }

}
