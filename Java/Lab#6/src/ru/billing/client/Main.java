package ru.billing.client;

import ru.billing.exceptions.CatalogLoadException;
import ru.billing.exceptions.ItemAlreadyExistsException;
import ru.billing.stocklist.*;
import java.util.*;

public class Main {
    public static void main(String[] args) throws ItemAlreadyExistsException, CatalogLoadException {
        CatalogFileLoader aaa = new CatalogFileLoader("/home/timurbabs/ITMO/Java/Lab#6/src/items.lst");
        ItemCatalog catalog = new ItemCatalog();
        CatalogStubLoader bbb = new CatalogStubLoader();
        bbb.load(catalog);
        aaa.load(catalog);
        catalog.printItems();
    }
}
