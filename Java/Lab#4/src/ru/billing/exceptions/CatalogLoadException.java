package ru.billing.exceptions;

public class CatalogLoadException extends Exception{
    public CatalogLoadException(Exception e) {
        super("CatalogLoadException");
    }
}
