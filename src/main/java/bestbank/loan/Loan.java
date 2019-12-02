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
            String[] cleanPayment = new String[6];

            // Copy over values
            cleanPayment[0] = payment[0];
            cleanPayment[1] = payment[1];
            cleanPayment[2] = payment[2];

            // Update Balance
            currentBalance = currentBalance - Double.parseDouble(payment[2]);
            cleanPayment[3] = Double.toString(currentBalance);

            // Append
            processedPayments.add(cleanPayment);
        }
    }

    public ArrayList<String[]> getProcessedPayments() {
        return this.processedPayments;
    }

}
