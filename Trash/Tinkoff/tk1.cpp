#include <iostream>

using namespace std;

int main()
{
	int a, b, x, y;
	cin >> a >> b >> x >> y;

    if (a == x) {
        cout << b << " " << a << " " << x << " " << y;
    }
    else if (b == x) {
        cout << a << " " << b << " " << x << " " << y;
    }
    else if (a == y) {
        cout << b << " " << a << " " << y << " " << x;
    }
    else if (b == y) {
        cout << a << " " << b << " " << y << " " << x;
    }
    else {
        cout << -1;
    }

	return 0;
}