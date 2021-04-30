#include <iostream>
using namespace std;

int main() {
    int m;
    cin >> m;
    int n;
    cin >> n;
    while (1) {
        aqa:
        int i;
        for (i = 2; i <= m; i++) {
            if (m % i == 0) {
                if (n % i == 0) {
                    m = m / i;
                    n = n / i;
                    goto aqa;
                }
            }
        }
        goto iq;
    }
    iq:
    cout << m;
    cout << n;
    return 0;
}