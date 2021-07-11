// 1.5
#include <iostream>
#include <cmath>

using namespace std;

typedef double (*func)(double);

double secant(func f, double x0, double x1, double tol)
{
    double x_prev = x0;
    double x_cur = x1;
    int iter = 1;
    while (1)
    {
        printf("iter%d: x=%.14lf\n", iter, x_cur);
        if (std::abs(x_cur - x_prev) < tol)
            break;
        double x = x_cur - f(x_cur) * (x_cur - x_prev) / (f(x_cur) - f(x_prev));
        x_prev = x_cur;
        x_cur = x;
        ++iter;
    }
}

double f(double x)
{
    return std::pow(x, 3) + x - 1;
}

int main()
{
    secant(f, 0, 1, 1e-6);
    return 0;
}