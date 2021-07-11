// 1.2
#include <iostream>
#include <cmath>

using namespace std;

typedef double (*func)(double);

/**
 * @brief use newton's method to solve equation
 * 
 * @param f : function
 * @param df: first derivative
 * @param x0: initial value
 * @param tol: tolerance
 * @return double 
 */
double newton(func f, func df, double x0, double tol)
{
    double x = x0;
    double prev;
    int iter = 0;
    while (1)
    {

        prev = x;
        x -= f(x) / df(x);
        printf("iter%d: prev=%lf x=%lf\n", iter, prev, x);
        ++iter;
        if (std::abs(x - prev) < tol)
            break;
    }
    return x;
}

double f(double x)
{
    return 2. / 3. * M_PI * x * x * x + 10. * M_PI * x * x - 400;
}

double df(double x)
{
    return 2 * M_PI * x * x + 20 * M_PI * x;
}
int main()
{
    double sol = newton(f, df, 4, 1e-4);
    cout << "sol=" << sol << endl;
    return 0;
}