package bestbank.passbook;

import java.util.ArrayList;

public class Passbook {

    private String accountNo;
    private ArrayList<String[]> transactions;
    private String[] balanceFwd;
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
            cleanTransaction[0] = transaction[0];
            cleanTransaction[1] = transaction[1];
            cleanTransaction[2] = transaction[2];

            // Make doubles pretty
            double debit = Double.parseDouble(transaction[3]);
            if (debit==0.0) cleanTransaction[3] = ""; else cleanTransaction[3] = "$" + transaction[3];

            double credit = Double.parseDouble(transaction[4]);
            if (credit==0.0) cleanTransaction[4] = ""; else cleanTransaction[4] = "$" + transaction[4];

            // Update Balance
            currentBalance = currentBalance + credit - debit;
            cleanTransaction[5] = Double.toString(currentBalance);

            // Append
            processedTransactions.add(cleanTransaction);
        }
    }

    public void setTransactions(ArrayList<String[]> transactions) {
        this.transactions = transactions;
    }

    public void setBalanceFwd(String[] balanceFwd) {
        this.balanceFwd = balanceFwd;
    }

    public String getAccountNo() {
        return this.accountNo;
    }

    public String[] getBalanceFwd() {
        return this.balanceFwd;
    }

    public ArrayList<String[]> getTransactions() {
        return this.transactions;
    }

    public ArrayList<String[]> getProcessedTransactions() {
        return this.processedTransactions;
    }
}
