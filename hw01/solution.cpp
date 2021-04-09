#include <iostream>
using namespace std;

int main() {
    int result = 0;
    int N;
    cin >> N; 
    for (int i = 1; i*i <= N; i++) {
        if (N % i == 0) result++;
    }
    cout << result;
    return 0;
}