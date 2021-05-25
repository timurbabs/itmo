package ru.billing.client;

import ru.billing.stocklist.*;
import java.util.*;

public class Main {
    public static void main(String[] args) {
        FoodItem item_1 = new FoodItem("Pepsi", 50, null, new Date(2017, Calendar.JUNE, 25), (short) 5);
        FoodItem item_2 = new FoodItem("Coca-cola", 55, item_1, new Date(2018, Calendar.AUGUST, 22), (short) 8);
        FoodItem item_3 = new FoodItem("ChipsLub", 65, null, new Date(2018, Calendar.FEBRUARY, 23), (short) 3);
        FoodItem item_4 = new FoodItem("AmericanShips", 80, item_3, new Date(2015, Calendar.OCTOBER, 12), (short) 5);
        FoodItem item_5 = new FoodItem("Apple from Russia", 25, null, new Date(2018, Calendar.JUNE, 31), (short) 7);
        FoodItem item_6 = new FoodItem("Apple from France", 55, item_5, new Date(2018, Calendar.SEPTEMBER, 2), (short) 5);
        FoodItem item_7 = new FoodItem("Bananas", 30, null, new Date(2019, Calendar.AUGUST, 1), (short) 2);
        FoodItem item_8 = new FoodItem("Snickers", 35, null, new Date(2018, Calendar.MAY, 15), (short) 3);
        FoodItem item_9 = new FoodItem("Twix", 35, item_8, new Date(2018, Calendar.JUNE, 25), (short) 7);
        FoodItem item_10 = new FoodItem("Pasta", 40, null, new Date(2018, Calendar.MARCH, 8), (short) 9);

        ItemCatalog myCatalog = new ItemCatalog();
        myCatalog.addItem(item_1);
        myCatalog.addItem(item_2);
        myCatalog.addItem(item_3);
        myCatalog.addItem(item_4);
        myCatalog.addItem(item_5);
        myCatalog.addItem(item_6);
        myCatalog.addItem(item_7);
        myCatalog.addItem(item_8);
        myCatalog.addItem(item_9);
        myCatalog.addItem(item_10);

        long begin = new Date().getTime();
        for(int i = 0; i < 100000; i++)
            myCatalog.findItemByID(10);
        long end = new Date().getTime();
        System.out.println("In HashMap: "+(end-begin)); begin = new Date().getTime();

        begin = new Date().getTime();
        for(int i = 0; i < 100000; i++)
            myCatalog.findItemByIDAL(10);
        end = new Date().getTime();
        System.out.println("In ArrayList: "+(end-begin));

        u0901WorkArray
        CatalogLoader loader = new CatalogStubLoader();
        loader.load(myCatalog);
        myCatalog.printItems();
    }
}
