#include <iostream>
#include <vector>
#include <stack>

using namespace std;

void find_ans(int index, vector<int> &ans, vector<int> &index_height) {
    if (ans[index] != -1) {
        return;
    }
    if (index_height[index] != -1) {
        find_ans(index_height[index], ans, index_height);
        ans[index] = ans[index_height[index]] + 1;
    }
    else {
        ans[index] = 1;
    }
}

int main()
{
    int n;
    cin >> n;

    vector<int> height(n);
    for (int i = 0; i < n; i++) {
        cin >> height[i];
    }

    vector<int> index_height(n, -1);
    deque<int> find_height, find_index;
    find_index.push_front(0);
    find_height.push_front(height[0]);
    for (int i = 1; i < n; i++)
    {
        while (!find_height.empty() && height[i] > find_height.front())
        {
            int g_i = find_index.front();
            index_height[g_i] = i;
            find_height.pop_front();
            find_index.pop_front();
        }
        find_index.push_front(i);
        find_height.push_front(height[i]);
    }

    vector<int> ans(n, -1);
    for (int i = 0; i < n; i++) {
        if (ans[i] == -1) {
            find_ans(i, ans, index_height);
        }
    }

    for(auto i: ans) {
        cout << i << " ";
    }
	return 0;
}

//6
//160
//160
//170
//172
//180
//180
//4 4 3 2 1 1