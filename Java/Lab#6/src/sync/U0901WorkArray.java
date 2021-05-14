package sync;

class U0901WorkArray<T extends Number> {
    T[] arrnums;
    public U0901WorkArray(T[] numP) {
        arrnums = numP;
    }
    double sum() {
        double doubleWork = 0;
        for (int i = 0; i < arrnums.length; i++) {
            doubleWork += Double.parseDouble(String.valueOf(arrnums[i]));
        }
        return doubleWork;
    }
}