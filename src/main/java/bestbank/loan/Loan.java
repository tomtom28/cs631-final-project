package bestbank.loan;

import java.util.ArrayList;

public class Loan {

    private String loanNo;
    private String dateTaken;
    private ArrayList<String[]> payments;
    private double loanPrincipal;
    private ArrayList<String[]> processedPayments;


    Loan (String loanNo, double loanPrincipal, String dateTaken) {
        this.loanNo = loanNo;
        this.loanPrincipal = loanPrincipal;
        this.dateTaken = dateTaken;
    }

    public void setPayments(ArrayList<String[]> payments) {
        this.payments = payments;
    }

    public void processPayments() {

        double currentBalance = this.loanPrincipal;
        processedPayments = new ArrayList<>(0);

        for(int i=0; i < payments.size(); i++) {
            String[] payment = payments.get(i);
            String[] cleanPayment = new String[3];

            // Copy over values
            cleanPayment[0] = payment[0]; // payment date
            cleanPayment[1] = String.format("%.2f", Double.parseDouble(payment[1])); // payment amount

            // Update Balance
            currentBalance = currentBalance - Double.parseDouble(payment[1]);
            cleanPayment[2] = String.format("%.2f", currentBalance); // updated balance

            // Append
            processedPayments.add(cleanPayment);
        }
    }

    public ArrayList<String[]> getProcessedPayments() {
        return this.processedPayments;
    }

    public String getProcessedPrincipal() {
        return String.format("%.2f", loanPrincipal);
    }

}
