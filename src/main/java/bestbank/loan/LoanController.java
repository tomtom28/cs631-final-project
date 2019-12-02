package bestbank.loan;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class LoanController {

    @GetMapping("/loans")
    public String view(String name, Model model) {
        return "loan";
    }

}
