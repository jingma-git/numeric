// 1.2
#include <iostream>
#include <cmath>

using namespace std;

typedef double (*func)(double);

/**
 * @brief Fixed point iteration
 * 
 * @param f 
 * @param x0: initial value
 * @param k : iteration num
 * @return double 
 */
double fpi(func f, double x0, double k)
{
    double x = f(x0); // x(i+1) = f(x(i))
    double prev;
    int iter = 0;
    while (k--)
    {
        prev = x;
        x = f(x);
        if (std::abs(x - prev) < 1e-6)
        {
            break;
        }
        printf("iter%d: x=%f\n", iter, x);
        ++iter;
    }
    return x;
}

double f1(double x)
{
    return 1 - std::pow(x, 3);
}

double f2(double x)
{
    return std::pow(1 - x, 1 / 3.0);
}

double f3(double x)
{
    return (1 + 2 * std::pow(x, 3)) / (1 + 3 * x * x);
}

int main()
{
    double x0 = 0.5;
    int k = 30;
    cout << "begin---------------f1" << endl;
    fpi(f1, x0, k);
    cout << "end---------------f1" << endl;

    cout << "begin---------------f2" << endl;
    fpi(f2, x0, k);
    cout << "end---------------f2" << endl;

    cout << "begin---------------f3" << endl;
    fpi(f3, x0, k);
    cout << "end---------------f3" << endl;
    return 0;
}