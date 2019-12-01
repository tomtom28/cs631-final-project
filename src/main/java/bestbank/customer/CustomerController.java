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
        model.addAttribute("name", name);
        return "customer";
    }

    @PostMapping("/customers/remove/customer")
    public String getPassbooksCustomer(@RequestParam(name="removeCustomerSSN") String customerSSN, Model model) {
        CustomerDAO customerDAO = new CustomerDAO();
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

}
