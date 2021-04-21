#include <iostream>
#include <vector>
#include <climits>

#define int long long

using namespace std;

signed main()
{
	int n, m, k;
	cin >> n >> m >> k;

	int price[n];
	for (int i = 0; i < n; i++) {
		cin >> price[i];
	}

	vector<int> ans(n, LLONG_MAX);
	ans[0] = k;
	for (int i = 1; i < n; i++) {
		int lmax = LLONG_MIN;
		int lmin = LLONG_MAX;

		ans[i] = ans[i - 1] + k;
		int j = i;
		while (j >= 0 && j >= i - m + 1) {
		    if(lmax < price[j]) {
		        lmax = price[j];
		    }
		    if(lmin > price[j]) {
                lmin = price[j];
            }
		    if(ans[i] > ans[j - 1] + (max(lmax, price[j]) - min(lmin, price[j])) * (i - j + 1) * (i - j + 1) + k) {
                ans[i] =  ans[j - 1] + (max(lmax, price[j]) - min(lmin, price[j])) * (i - j + 1) * (i - j + 1) + k;
            }
			j--;
		}
	}

	cout << ans.back();
	return 0;
}

//3 2 10
//100
//200
//500
//30