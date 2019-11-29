package bestbank.passbook;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class PassbookController {
    @GetMapping("/passbooks")
    public String view(String name) {
        return "passbook";
    }
}
