package bestbank.passbook;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.sql.Connection;
import java.util.ArrayList;

@Controller
public class PassbookController {
    @GetMapping("/passbooks")
    public String view() {
        return "passbook";
    }

//    @GetMapping("/passbook/account/{accountNo}")
//    public String getPassbookForAccount(@PathVariable(value="accountNo") String accountNo, Model model) {
//        model.addAttribute("accountNo", accountNo);
//        return "passbook";
//    }

    @PostMapping("/passbooks/account")
    public String getPassbookForAccount(@RequestParam(name="accountNo") String accountNo, Model model) {
        // Checks if Account Number Exists
        PassbookDAO passbookDAO = new PassbookDAO();
        if (passbookDAO.isValidAccountNo(accountNo)) {
            model.addAttribute("account", accountNo);
            // Create Passbook
            Passbook passbook = new Passbook(accountNo);
//            passbook.setBalanceFwd(passbookDAO.getBalanceFwd(accountNo));
            passbook.setTransactions(passbookDAO.getTransactions(accountNo));
            passbook.processTransactions();

            // Send to Template
//            model.addAttribute("balance", new String[][] {passbook.getBalanceFwd()});
            model.addAttribute("transactions", passbook.getProcessedTransactions());
        } else {
            model.addAttribute("error", "Account No: \"" + accountNo + "\" was not found! Please try another 9-digit account number.");
        }
        passbookDAO.close();
        return "passbook";
    }

}
