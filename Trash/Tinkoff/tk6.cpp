#include <iostream>
#include <climits>

using namespace std;

int n;
int m;
long long a[100010];

bool check(long long value) {
    long long res = 0;
    for (int i = 0; i != m; i++) {
        res += value / (a[i] * 2);
        if (value % (a[i] * 2) >= a[i]) {
            res++;
        }
    }
    return res >= n;
}

int main()
{
    cin >> n >> m;
    for (int i = 0; i < m; i++) {
        cin >> a[i];
    }

    long long l = 0, r = LLONG_MAX;

    while (l + 1 < r) {
        long long mid = (r + l) >> 1;
        if (check(mid)) {
            r = mid;
        }
        else {
            l = mid;
        }
    }

    if(check(l)) {
        cout << l;
    }
    else {
        cout << r;
    }
	return 0;
}
