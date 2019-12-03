package bestbank.passbook;

import java.util.ArrayList;

public class Passbook {

    private String accountNo;
    private ArrayList<String[]> transactions;
    private ArrayList<String[]> processedTransactions;

    public Passbook(String accountNo) {
        this.accountNo = accountNo;
    }

    public void processTransactions() {

        double currentBalance = 0.0;
        processedTransactions = new ArrayList<>(0);
        for(int i=0; i < transactions.size(); i++) {
            String[] transaction = transactions.get(i);
            String[] cleanTransaction = new String[6];

            // Copy over values
            cleanTransaction[0] = transaction[0]; // transaction date
            cleanTransaction[1] = transaction[1]; // transaction code
            cleanTransaction[2] = transaction[2]; // transaction name

            // Make doubles pretty
            double debit = Double.parseDouble(transaction[3]);
            if (debit==0.0) cleanTransaction[3] = ""; else cleanTransaction[3] = "$" + String.format("%.2f", Double.parseDouble(transaction[3])); // debit amount (to 0.00)

            double credit = Double.parseDouble(transaction[4]);
            if (credit==0.0) cleanTransaction[4] = ""; else cleanTransaction[4] = "$" + String.format("%.2f", Double.parseDouble(transaction[4])); // credit amount (to 0.00)

            // Update Balance
            currentBalance = currentBalance + credit - debit;
            cleanTransaction[5] = String.format("%.2f", currentBalance); // updated balance (to 0.00)

            // Append
            processedTransactions.add(cleanTransaction);
        }
    }

    public void setTransactions(ArrayList<String[]> transactions) {
        this.transactions = transactions;
    }


    public String getAccountNo() {
        return this.accountNo;
    }

    public ArrayList<String[]> getTransactions() {
        return this.transactions;
    }

    public ArrayList<String[]> getProcessedTransactions() {
        return this.processedTransactions;
    }
}
