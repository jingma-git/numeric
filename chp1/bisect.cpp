// 1.1
#include <iostream>
#include <cmath>
#include <cassert>
using namespace std;

typedef double (*func)(double);

double f(double x)
{
    return std::pow(x, 3) + x - 1;
}
// the approximate solution for f(x) = 0
double bisect(func f,
              double a, double b, double tol)
{
    double l = f(a);
    double r = f(b);
    if (l * r >= 0)
    {
        assert(false && "f(a)*f(b)<0 not satisfied!");
    }
    int iter = 0;
    while ((b - a) > tol)
    {
        double c = (a + b) * 0.5;
        double m = f(c); // middle
        if (m == 0)
            return m;
        if (l * m < 0)
        {
            b = c;
            r = m;
        }
        else // r*m < 0
        {
            a = c;
            l = m;
        }
        printf("iter%d: a=%f, b=%f, c=%f\n", iter, a, b, c);
        ++iter;
    }
    return (a + b) * 0.5;
}

int main()
{
    double sol = bisect(f, 0, 1, 1e-5);
    cout << sol << endl;
    return 0;
}