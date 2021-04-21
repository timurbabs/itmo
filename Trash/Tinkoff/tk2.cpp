#include <iostream>
#include <string>
#include <set>

using namespace std;

int main() {
    string nickname;
    cin >> nickname;

    set<char> vowels = {'a','o','e','u','i','y'};
    set<char> consonants = {'b','c','d','f','g','h','j','k','l','m','n','p','q','r','s','t','v','w','x','z'};

    bool ans = true;
    for (int i = 0; i != nickname.length() - 1; i++) {
        if ((vowels.count(nickname[i]) != 0 && consonants.count(nickname[i + 1]) != 0) ||
            (consonants.count(nickname[i]) != 0 && vowels.count(nickname[i + 1]) != 0)) {
            ans = true;
        }
        else {
            ans = false;
            break;
        }
    }

    if(ans) {
        cout << "YES";
    }
    else {
        cout << "NO";
    }
    return 0;
}