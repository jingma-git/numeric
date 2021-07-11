// 1.5 IQI: inverse quadratic interpolation
#include <iostream>
#include <cmath>

using namespace std;

typedef double (*func)(double);

double iqi(func f, double x0, double x1, double x2)
{
    int iter = 3;

    while (1)
    {
        double A = f(x0);
        double B = f(x1);
        double C = f(x2);
        printf("iter%d: x=%.6f fx=%e\n", iter, x2, C);
        if (std::abs(C) < 1e-14)
            break;
        double q = A / B;
        double r = C / B;
        double s = C / A;
        double x = x2 - (r * (r - q) * (x2 - x1) + (1 - r) * s * (x2 - x0)) / ((q - 1) * (r - 1) * (s - 1));
        double tmp_x = x0 * B * C / ((A - B) * (A - C)) + x1 * A * C / ((B - A) * (B - C)) + x2 * A * B / ((C - A) * (C - B));
        x0 = x;
        ++iter;
    }
}

double f(double x)
{
    return std::pow(x, 3) + x - 1;
}

int main()
{
    iqi(f, 0, 1, 0.5);
    return 0;
}