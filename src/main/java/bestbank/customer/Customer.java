package bestbank.customer;

public class Customer {

    private String firstName;
    private String lastName;
    private String ssn;
    private String street;
    private String apt;
    private String city;
    private String state;
    private String zip;

    private boolean hasAptNo;


    Customer(String firstName, String lastName, String ssn, String street, String apt, String city, String state, String zip) {

        this.firstName = firstName.trim();
        this.lastName = lastName.trim();
        this.ssn = ssn.trim();
        this.street = street.trim();
        this.apt = apt.trim();
        this.city = city.trim();
        this.state = state.trim();
        this.zip = zip.trim();

        // Determines if Customer has Apt No (if not empty)
        if(!apt.equals("")) {
            this.hasAptNo = true;
        }

        int tom = 0;

    }

    public boolean hasAptNo() {
        return this.hasAptNo;
    }

    public String getFirstName() {
        return firstName;
    }

    public String getLastName() {
        return lastName;
    }

    public String getSSN() {
        return ssn;
    }

    public String getStreet() {
        return street;
    }

    public String getApt() {
        return apt;
    }

    public String getCity() {
        return city;
    }

    public String getState() {
        return state;
    }

    public String getZip() {
        return zip;
    }
}
