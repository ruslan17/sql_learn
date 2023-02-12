package com;


import java.util.List;

public class Author {
    String name;
    List<Book> books;

    static class Book {
        String name;

        List<Author> authors;
    }

}
