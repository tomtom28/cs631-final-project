package bestbank.customer;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.sql.SQLException;
import java.util.ArrayList;

@Controller
public class CustomerController {

    @GetMapping("/customers")
    public String view(String name, Model model) {

        // Get current bank branches (for drop down)
        CustomerDAO customerDAO = new CustomerDAO();
        this.appendAllBranches(model, customerDAO);
        customerDAO.close();

        return "customer";
    }

    @PostMapping("/customers/remove/customer")
    public String removeCustomer(@RequestParam(name="ssn") String customerSSN, Model model) {
        CustomerDAO customerDAO = new CustomerDAO();
        this.appendAllBranches(model, customerDAO); // for branches drop down

        String actionType = "[Remove an Existing Customer]";
        if (customerDAO.isValidCustomerSSN(customerSSN)) {
            // Try to delete from DB
            try {
                customerDAO.deleteCustomerBySSN(customerSSN);
                model.addAttribute("success","Action " + actionType + " Completed: " +
                        "Customer with SSN: \"" + customerSSN + "\" has been removed.");
            } catch (SQLException e) {
                model.addAttribute("error","Action " + actionType + " Failed: " +
                        e.getMessage()); // message from DB
            }

        } else {
            model.addAttribute("error","Action " + actionType + " Failed: " +
                        "Customer with SSN: \"" + customerSSN + "\" was not found!");
        }
        customerDAO.close();
        return "customer";
    }

    @PostMapping("/customers/add/customer")
    public String addCustomer(@RequestParam(name="firstName") String firstName,
                              @RequestParam(name="lastName") String lastName,
                              @RequestParam(name="ssn") String ssn,
                              @RequestParam(name="street") String street,
                              @RequestParam(name="apt") String apt,
                              @RequestParam(name="city") String city,
                              @RequestParam(name="state") String state,
                              @RequestParam(name="zip") String zip, Model model) {

        // Create Customer & DAO object
        Customer customer = new Customer(firstName, lastName, ssn, street, apt, city, state, zip);
        CustomerDAO customerDAO = new CustomerDAO();
        this.appendAllBranches(model, customerDAO); // for branches drop down

        String actionType = "[Add a New Customer]";
        try {
            customerDAO.addNewCustomer(customer);
            model.addAttribute("success","Action " + actionType + " Completed: " +
                    "Customer name: \"" + firstName + " " + lastName + "\" with SSN: \"" + ssn + "\" has been added.");
        } catch (SQLException e) {
            model.addAttribute("error","Action " + actionType + " Failed: " +
                    e.getMessage()); // message from DB
        }finally {
            customerDAO.close();
        }
        return "customer";
    }

    @PostMapping("/customers/add/account")
    public String addCustomer(@RequestParam(name="ssn") String ssn,
                              @RequestParam(name="branchName") String branchName,
                              @RequestParam(name="accountType") String accountType,
                              @RequestParam(name="interestOrOverdraft") String interestOrOverdraft,
                              @RequestParam(name="balance") String balanceStr, Model model) {

        // Create Customer & DAO object
        CustomerDAO customerDAO = new CustomerDAO();
        this.appendAllBranches(model, customerDAO); // for branches drop down

        double balance = Double.parseDouble(balanceStr);

        String actionType = "[Add a New Account]";

        if(balance < 500.0)
        {
            model.addAttribute("error","Action " + actionType + " Failed: " +
                    "The minimum amount to create an account is $500.00"); // custom message

            return "customer";
        }

        try {
            String accountNo = customerDAO.addNewAccount(ssn, branchName, accountType, interestOrOverdraft, balance);
            model.addAttribute("success","Action " + actionType + " Completed: " +
                    "Account No: " + accountNo + " added to Branch: " + branchName + " for Customer SSN: " + ssn + ".");
        } catch (SQLException e) {
            model.addAttribute("error","Action " + actionType + " Failed: " +
                    e.getMessage()); // message from DB
        } finally {
            customerDAO.close();
        }
        return "customer";
    }


    @PostMapping("/customers/remove/account")
    public String removeAccount(@RequestParam(name="accountNo") String accountNo,  Model model){

        // Create Customer & DAO object
        CustomerDAO customerDAO = new CustomerDAO();
        this.appendAllBranches(model, customerDAO); // for branches drop down

        String actionType = "[Remove Account]";
        try {
            String removedAccountNo = customerDAO.removeCustomerAccount(accountNo);
            model.addAttribute("success","Action " + actionType + " Completed: " +
                    "Account No: " + removedAccountNo + " has successfully been removed.");
        } catch (SQLException e) {
            model.addAttribute("error","Action " + actionType + " Failed: " +
                    e.getMessage()); // message from DB
        }finally {
            customerDAO.close();
        }

        return "customer";
    }

    @PostMapping("/customers/add/loan")
    public String addLoan(@RequestParam(name="ssn") String ssn,
                          @RequestParam(name="branchName") String branchName,
                          @RequestParam(name="amount") String amount ,Model model){

        // Create Customer & DAO object
        CustomerDAO customerDAO = new CustomerDAO();
        this.appendAllBranches(model, customerDAO); // for branches drop down

        String actionType = "[Add Loan]";
        try {
            String addedLoanNo = customerDAO.addCustomerLoan(ssn, branchName, amount);
            model.addAttribute("success","Action " + actionType + " Completed: " +
                    "Loan No: " + addedLoanNo + " has successfully been added.");
        } catch (SQLException e) {
            model.addAttribute("error","Action " + actionType + " Failed: " +
                    e.getMessage()); // message from DB
        }finally {
            customerDAO.close();
        }

        return "customer";
    }


    @PostMapping("/customers/remove/loan")
    public String removeLoan(@RequestParam(name="loanNo") String loanNo,  Model model){

        // Create Customer & DAO object
        CustomerDAO customerDAO = new CustomerDAO();
        this.appendAllBranches(model, customerDAO); // for branches drop down

        String actionType = "[Remove Loan]";
        try {
            String removedLoanNo = customerDAO.removeCustomerLoan(loanNo);
            model.addAttribute("success","Action " + actionType + " Completed: " +
                    "Loan No: " + removedLoanNo + " has successfully been removed.");
        } catch (SQLException e) {
            model.addAttribute("error","Action " + actionType + " Failed: " +
                    e.getMessage()); // message from DB
        }finally {
            customerDAO.close();
        }

        return "customer";
    }



    // Get current bank branches (for drop down)
    private void appendAllBranches(Model model, CustomerDAO customerDAO) {
        ArrayList<String> branches = customerDAO.getAllBankBranches();
        model.addAttribute("branches", branches);
    }

}
