#include <iostream>

constexpr int SIZE = 1000;
int arr[SIZE][SIZE];

int main() {
    int input;
    std::cin >> input;
    for(int y = 0; y < SIZE; y++)
        for(int x = 0; x < SIZE; x++)
            arr[y][x] = 0;

    constexpr auto y0 = SIZE/2;
    constexpr auto x0 = SIZE/2;

    int y=0, x=0;
    int dy = 0, dx = 1;
    int i = 1;
    arr[y0+y][x0+x] = i;
    int ans2 = 0;
    while(i < input) {
        i++;
        y += dy;
        x += dx;
        for (int yy = -1; yy <= 1; yy++) {
            for (int xx = -1; xx <= 1; xx++) {
                if(xx == 0 && yy == 0) continue;
                arr[y0+y][x0+x] += arr[y0+y+yy][x0+x+xx];
            }
        }
        if(!ans2 && arr[y0+y][x0+x] > input) ans2 = arr[y0+y][x0+x];
        if(dy == 0 && dx == 1) {
            if(arr[y0+y-1][x0+x] == 0) { dy = -1; dx = 0; }
        } else if(dy == -1 && dx == 0) {
            if(arr[y0+y][x0+x-1] == 0) { dy = 0; dx = -1; }
        } else if(dy == 0 && dx == -1) {
            if(arr[y0+y+1][x0+x] == 0) { dy = 1; dx = 0; }
        } else if(dy == 1 && dx == 0) {
            if(arr[y0+y][x0+x+1] == 0) { dy = 0; dx = 1; }
        }
    }

    int ans1 = abs(y) + abs(x);
    std::cout << ans1 << std::endl;
    std::cout << ans2 << std::endl;
}
