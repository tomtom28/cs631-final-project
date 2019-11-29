package bestbank.customer;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
public class CustomerController {

    @GetMapping("/customers")
    public String view(String name, Model model) {
        model.addAttribute("name", name);
        return "customer";
    }

}
