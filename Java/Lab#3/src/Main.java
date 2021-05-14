import java.util.*;

public class Main {
    public static void main(String[] args) {
        Integer intArr[] = {10, 25, 15};

        Float[] floatArr = new Float[10];
        for (int i = 0; i < floatArr.length; i++) {
            floatArr[i] = (float)Math.round(Math.random() * 10);
        }

        u0901WorkArray insWorkArrayInt = new u0901WorkArray(intArr);
        u0901WorkArray insWorkArrayFloat = new u0901WorkArray(floatArr);

        System.out.println("Sum of int:" + insWorkArrayInt.sum());
        System.out.println("Sum of float:" + insWorkArrayFloat.sum());

        String line = "Конфеты ’Маска’;45;120";
        String item_fld[] = line.split(";");
        System.out.println(Arrays.toString(item_fld));
        FoodItem itemFromString = new FoodItem(item_fld[0], Float.parseFloat(item_fld[1]), Short.parseShort(item_fld[2]));
        itemFromString.printAll();
    }
}
