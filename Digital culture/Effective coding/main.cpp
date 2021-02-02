#include <iostream>
#include <cmath>
#include "bitmap_image.hpp"

using namespace std;

int main()
{
    bitmap_image image("image_ch_b.bmp");
    int picture[128][128];
    for (int i = 0; i < image.width(); i++)
        {
            for (int j = 0; j < image.height(); j++)
            {
                rgb_t colour;
                image.get_pixel(i, j, colour);
                picture[i][j] = colour.red;
            }
        }

    cout << "Sequence:" << endl;

    int freq[261];
    for (int i = 0; i < 128; i++)
        {
            picture[i][64] = round(double(picture[i][64]) / 20) * 20;
            freq[picture[i][64]]++;
            cout << picture[i][64] << ' ';
        }

    cout << endl << endl << "Count and frequency:" << endl;

    float entropy = 0;
    for (int i = 0; i < 261; i++)
    {
        if (freq[i] != 0)
        {
            cout << i << ' ' << freq[i] << endl;
            entropy -= (double(freq[i]) / 128) * log2(double(freq[i]) / 128);
        }
    }

    cout << endl;

    cout << "Entropy = " << entropy;
    return 0;
}
