package ru.billing.stocklist;

import java.util.Date;

public class FoodItem extends GenericItem {
    private Date dateOfIncome; // дата производства
    private short expires; // срок годности

    public Date getDateOfIncome() {
        return dateOfIncome;
    }

    public void setDateOfIncome(Date dateOfIncome) {
        this.dateOfIncome = dateOfIncome;
    }

    public short getExpires() {
        return expires;
    }

    public void setExpires(short expires) {
        this.expires = expires;
    }

    public FoodItem(String name, float price, FoodItem analog, Date date, short expires) {
        this.setName(name);
        this.setPrice(price);
        this.setAnalog(analog);
        this.setAnalog(analog);
        this.setExpires(expires);
    }

    FoodItem(String name, float price, short expires) {
        this(name, price, null, null, expires);
    }

    public FoodItem(String name) {
        this(name, 0, null, null, (short) 0);
    }

    public FoodItem() {
        this(null, 0, null, null, (short) 0);
    }

    @Override
    public boolean equals(Object o) {
        if (this == o)
            return true;

        else if (o instanceof GenericItem)
        {
            FoodItem p = (FoodItem) o;
            return (this.getID() == p.getID())
                    && (this.getItemCategory() == p.getItemCategory())
                    && (this.getName().equals(p.getName()))
                    && (this.getAnalog() == p.getAnalog())
                    && (this.getPrice() == p.getPrice())
                    && (this.getExpires() == p.getExpires())
                    && (this.getDateOfIncome().equals(p.getDateOfIncome()));
        }
        return false;
    }

    @Override
    public FoodItem clone() {
        FoodItem p = new FoodItem();
        p.setID(this.getID());
        p.setAnalog(this.getAnalog());
        p.setName(this.getName());
        p.setPrice(this.getPrice());
        p.setItemCategory(this.getItemCategory());
        p.setExpires(this.getExpires());
        p.setDateOfIncome(this.getDateOfIncome());
        return p;
    }

    @Override
    public String toString() {
        return "ru.billing.stocklist.FoodItem{" +
                "ID=" + this.getID() +
                ", name='" + this.getName() + '\'' +
                ", price=" + this.getPrice() +
                ", analog=" + this.getAnalog() +
                ", itemCategory=" + this.getItemCategory() +
                ", dateOfIncome=" + this.getDateOfIncome() +
                ", expires=" + this.getExpires() +
                '}';
    }

    @Override
    void printAll() {
        System.out.printf("ID: %d , Name: %-15s , price: %5.2f, category: %-15s, dateOfIncome: %ty.%5$tm.%5$td, expires: %d \n", this.getID(), this.getName(), this.getPrice(), this.getItemCategory(), this.getDateOfIncome(), this.getExpires());
    }
}
