public class GenericItem {
    public static int currentID;
    public int ID;
    public String name;
    public float price;
    public GenericItem analog;
    public Category itemCategory = Category.GENERAL;

    public GenericItem(String name, float price, Category category) {
        this.name = name;
        this.price = price;
        this.itemCategory = category;
        this.ID = GenericItem.currentID++;
    }
    public GenericItem(String name, float price, GenericItem analog) {
        this.name = name;
        this.price = price;
        this.analog = analog;
        this.ID = GenericItem.currentID++;
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
        return "GenericItem{" +
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
