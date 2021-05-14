package sync;

public class U1901Thread extends Thread{
    U1901Bank bankWork;
    int intTrans;
    long lngSleep;

    U1901Thread (int sumTrans, int sleepTime, U1901Bank bank) {
        this.intTrans = sumTrans;
        this.lngSleep = sleepTime;
        this.bankWork = bank;
    }

    public void run() {
        bankWork.calc(intTrans, lngSleep);
    }
}
