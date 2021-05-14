package ru.billing.stocklist;

public class GenericItem {
    private static int currentID;
    private int ID;
    private String name;
    private float price;
    private GenericItem analog;
    private Category itemCategory = Category.GENERAL;

    public static int getCurrentID() {
        return currentID;
    }

    public static void setCurrentID(int currentID) {
        GenericItem.currentID = currentID;
    }

    public int getID() {
        return ID;
    }

    public void setID(int ID) {
        this.ID = ID;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public float getPrice() {
        return price;
    }

    public void setPrice(float price) {
        this.price = price;
    }

    public GenericItem getAnalog() {
        return analog;
    }

    public void setAnalog(GenericItem analog) {
        this.analog = analog;
    }

    public Category getItemCategory() {
        return itemCategory;
    }

    public void setItemCategory(Category itemCategory) {
        this.itemCategory = itemCategory;
    }

    public GenericItem(String name, float price, Category category) {
        this.name = name;
        this.price = price;
        this.itemCategory = category;
    }
    public GenericItem(String name, float price, GenericItem analog) {
        this.name = name;
        this.price = price;
        this.analog = analog;
    }
    public GenericItem(){
        this.ID = GenericItem.currentID++;
    }

    @Override
    public boolean equals(Object o) {
        // ссылаются ли оба объекта на один и тот же экземпляр
        if (this == o)
            return true;

        // имеет ли "o" значение экземпляра, а затем сравнивает каждое отдельное поле, необходимое для определения того, равны ли оба объекта
        else if (o instanceof GenericItem)
        {
            GenericItem p = (GenericItem) o;
            return (this.ID == p.ID)
                    && (this.itemCategory == p.itemCategory)
                    && (this.name.equals(p.name))
                    && (this.analog == p.analog)
                    && (this.price == p.price);
        }
        return false;
    }

    @Override
    public GenericItem clone() {
        GenericItem p = new GenericItem();
        p.ID = this.ID;
        p.analog = this.analog;
        p.name = this.name;
        p.price = this.price;
        p.itemCategory = this.itemCategory;
        return p;
    }

    @Override
    public String toString() {
        return "ru.billing.stocklist.GenericItem{" +
                "ID=" + ID +
                ", name='" + name + '\'' +
                ", price=" + price +
                ", analog=" + analog +
                ", itemCategory=" + itemCategory +
                '}';
    }

    public GenericItem clone_analog() {
        return analog.clone();
    }

    void printAll() {
        System.out.printf("ID: %d , Name: %-15s , price: %5.2f, category: %-15s \n", ID, name, price, itemCategory);
    }
}
