package ru.billing.stocklist;

public class TechnicalItem extends GenericItem{
    private short warrantyTime; // гарантийный срок (суток)

    public short getWarrantyTime() {
        return warrantyTime;
    }

    public void setWarrantyTime(short warrantyTime) {
        this.warrantyTime = warrantyTime;
    }

    public TechnicalItem(String name, float price, FoodItem analog, short warrantyTime) {
        this.setName(name);
        this.setPrice(price);
        this.setAnalog(analog);
        this.setWarrantyTime(warrantyTime);
    }

    TechnicalItem(String name, float price, short expires) {
        this(name, price, null, (short) 0);
    }

    public TechnicalItem(String name) {
        this(name, 0, null, (short)0);
    }

    public TechnicalItem() {
        this(null, 0, null, (short) 0);
    }

    @Override
    public boolean equals(Object o) {
        if (this == o)
            return true;

        else if (o instanceof GenericItem)
        {
            TechnicalItem p = (TechnicalItem) o;
            return (this.getID() == p.getID())
                    && (this.getItemCategory() == p.getItemCategory())
                    && (this.getName().equals(p.getName()))
                    && (this.getAnalog() == p.getAnalog())
                    && (this.getPrice() == p.getPrice())
                    && (this.getWarrantyTime() == p.getWarrantyTime());
        }
        return false;
    }

    @Override
    public TechnicalItem clone() {
        TechnicalItem p = new TechnicalItem();
        p.setID(this.getID());
        p.setAnalog(this.getAnalog());
        p.setName(this.getName());
        p.setPrice(this.getPrice());
        p.setItemCategory(this.getItemCategory());
        p.setWarrantyTime(this.getWarrantyTime());
        return p;
    }

    @Override
    public String toString() {
        return "ru.billing.stocklist.TechnicalItem{" +
                "ID=" + this.getID() +
                ", name='" + this.getName() + '\'' +
                ", price=" + this.getPrice() +
                ", analog=" + this.getAnalog() +
                ", itemCategory=" + this.getItemCategory() +
                ", warrantyTime=" + this.getWarrantyTime() +
                '}';
    }

    @Override
    void printAll() {
        System.out.printf("ID: %d , Name: %-15s , price: %5.2f, category: %-15s, warrantyTime: %d \n", this.getID(), this.getName(), this.getPrice(), this.getItemCategory(), this.getWarrantyTime());
    }
}
