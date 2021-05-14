package ru.billing.client;

import ru.billing.exceptions.CatalogLoadException;
import ru.billing.exceptions.ItemAlreadyExistsException;
import ru.billing.stocklist.FoodItem;
import ru.billing.stocklist.ItemCatalog;

import java.io.*;
import java.util.Date;
import java.util.Scanner;

public class CatalogFileLoader implements CatalogLoader{
    private final String fileName;

    public CatalogFileLoader(String fileName) {
        this.fileName = fileName;
    }

    @Override
    public void load(ItemCatalog cat) throws CatalogLoadException {
        File f = new File(fileName);
        FileInputStream fis;
        InputStreamReader read;
        String line;
        try {
            fis = new FileInputStream(f);
            read = new InputStreamReader(fis, "WINDOWS-1251");
            Scanner s = new Scanner(read);
            while (s.hasNextLine()) {
                line = s.nextLine();
                if (line.length() == 0)
                    break;
                String[] item_fld = line.split(";");
                String name = item_fld[0];
                float price = Float.parseFloat(item_fld[1]);
                short expires = Short.parseShort(item_fld[2]);
                FoodItem item = new FoodItem(name, price, null, new Date(), expires);
                cat.addItem(item);
            }
        } catch (FileNotFoundException | ItemAlreadyExistsException | UnsupportedEncodingException e) {
            e.printStackTrace();
            throw new CatalogLoadException(e);
        }
    }
}
