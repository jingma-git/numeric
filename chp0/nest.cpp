#include <iostream>
#include <cmath>
#include <Eigen/Eigen>
using namespace std;
using namespace Eigen;

double nest(int d,
            const VectorXd &c,
            double x,
            const VectorXd &b)
{

    double y = c(d);
    for (int i = d - 1; i >= 0; --i)
    {
        y = (x - (b(i))) * y + c(i);
    }
    return y;
}

int main()
{
    // -1 + 5*x - 3*x^2 + 3*x^3 + 2*x^4
    int d = 4;
    VectorXd c(d + 1);
    double x = 1. / 2.;
    VectorXd b = VectorXd::Zero(d);
    c << -1, 5, -3, 3, 2;
    double y = nest(d, c, x, b);
    cout << "y=" << y << endl;

    // prac1
    d = 51;
    c = VectorXd::Ones(d + 1);
    x = 1.00001;
    b = VectorXd::Zero(d);
    y = nest(d, c, x, b);
    cout << "y=" << y << endl;
    double Qx = (std::pow(x, 51) - 1.) / (x - 1);
    cout << "Q(x)=" << Qx << endl;
    return 0;
}