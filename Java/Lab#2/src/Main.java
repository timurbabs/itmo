import java.util.ArrayList;
import java.util.Calendar;
import java.util.GregorianCalendar;
import java.util.List;

public class Main {
    public static void main(String[] args) {
        GenericItem item_1 = new GenericItem();
        item_1.ID = 1;
        item_1.name = "Pepsi";
        item_1.price = 50;
        item_1.itemCategory = Category.FOOD;
        item_1.printAll();

        GenericItem item_2 = new GenericItem();
        item_2.ID = 2;
        item_2.name = "Coca-cola";
        item_2.price = 45;
        item_1.itemCategory = Category.FOOD;
        item_2.printAll();

        GenericItem item_3 = new GenericItem();
        item_3.ID = 3;
        item_3.name = "Snickers";
        item_3.price = 25;
        item_1.itemCategory = Category.FOOD;
        item_3.printAll();

        TechnicalItem item_4 = new TechnicalItem();
        item_4.ID = 4;
        item_4.name = "Computer";
        item_4.price = 1000;
        item_4.itemCategory = Category.GENERAL;
        item_4.warrantyTime = 364;

        FoodItem item_5 = new FoodItem();
        item_5.ID = 5;
        item_5.name = "Sausage";
        item_5.price = 65;
        item_5.analog = item_4;
        item_5.itemCategory = Category.FOOD;
        item_5.dateOfIncome = new java.util.Date(2017, Calendar.JUNE, 25);

        ArrayList<GenericItem> items = new ArrayList<>();
        items.add(item_4);
        items.add(item_5);
        for (GenericItem item : items) {
            item.printAll();
        }

        if(item_5.equals(item_5.clone())) {
            System.out.printf("They are equal!%n");
            System.out.printf(item_5.toString() + "%n");
            System.out.printf(item_5.clone_analog().toString() + "%n");
        }
    }
}
