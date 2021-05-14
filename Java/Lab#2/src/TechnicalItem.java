public class TechnicalItem extends GenericItem{
    short warrantyTime; // гарантийный срок (суток)

    @Override
    public boolean equals(Object o) {
        if (this == o)
            return true;

        else if (o instanceof GenericItem)
        {
            TechnicalItem p = (TechnicalItem) o;
            return (this.ID == p.ID)
                    && (this.itemCategory == p.itemCategory)
                    && (this.name.equals(p.name))
                    && (this.analog == p.analog)
                    && (this.price == p.price)
                    && (this.warrantyTime == p.warrantyTime);
        }
        return false;
    }

    @Override
    public TechnicalItem clone() {
        TechnicalItem p = new TechnicalItem();
        p.ID = this.ID;
        p.analog = this.analog;
        p.name = this.name;
        p.price = this.price;
        p.itemCategory = this.itemCategory;
        p.warrantyTime = this.warrantyTime;
        return p;
    }

    @Override
    public String toString() {
        return "TechnicalItem{" +
                "ID=" + ID +
                ", name='" + name + '\'' +
                ", price=" + price +
                ", analog=" + analog +
                ", itemCategory=" + itemCategory +
                ", warrantyTime=" + warrantyTime +
                '}';
    }

    @Override
    void printAll() {
        System.out.printf("ID: %d , Name: %-15s , price: %5.2f, category: %-15s, warrantyTime: %d \n", ID, name, price, itemCategory, warrantyTime);
    }
}
