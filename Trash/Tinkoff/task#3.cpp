#include <iostream>

using namespace std;

#define int long long


signed main()
{
	int a, b, c, t;
	cin >> a >> b >> c >> t;

	int minutes = c;
	int hour = c * b;
	int day = c * b * a;
	int denis_hour, denis_minutes, denis_seconds;

	int temp = t % day;
	denis_hour = temp / hour;

	temp %= hour;
	denis_minutes = temp / minutes;

	temp %= minutes;
	denis_seconds = temp;

	cout << denis_hour << " " << denis_minutes << " " << denis_seconds;
	return 0;
}