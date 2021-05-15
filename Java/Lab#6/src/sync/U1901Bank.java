package sync;

public class U1901Bank {
    public int intTo;
    public int intFrom = 220;

    synchronized void calc(int intTransaction, long lngTimeout) {
        System.out.println("Before-- From:" + intFrom + "    To:" + intTo + "    Thread name:" + Thread.currentThread().getName());
        intFrom = intFrom - intTransaction;
        try {
            Thread.sleep(lngTimeout);
        } catch (Exception e) {
            e.printStackTrace();
        }
        intTo = intTo + intTransaction;
        System.out.println("After-- From:" + intFrom + "    To:" + intTo + "    Thread name:" + Thread.currentThread().getName());
    }
}