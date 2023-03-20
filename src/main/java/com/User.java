package com;

import java.time.LocalDate;
import java.util.List;
import java.util.Set;

public class User {

    String name;
    int age;
    Account address;
    List<Address> addresses;
    Set<String> phoneNumbers;
    LocalDate birthday;

    static class Address {
        String addressLine1;
        String addressLine2;

        User user;
    }

    static class Account {
        String number;
    }
}

class TreeNode {
    TreeNode parent;
    List<TreeNode> children;

    void A() {
        b();
    }
    void b() {
        // 1
        // 2
        // 3
    }
}
