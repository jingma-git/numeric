#include "cg.h"
#include <iostream>
#include <Eigen/IterativeLinearSolvers>
using namespace std;
using namespace Eigen;
typedef SparseMatrix<double> SpMat;
typedef Triplet<double> Triple;

void setup(SpMat &A, int n)
{
    vector<Triple> data;
    for (int i = 0; i < n; ++i)
    {
        data.push_back(Triple(i, i, std::sqrt(i + 1)));

        double v = std::cos(1 + i);
        if (i + 10 < n)
        {
            data.push_back(Triple(i, i + 10, v));
            data.push_back(Triple(i + 10, i, v));
        }
    }
    A.resize(n, n);
    A.setFromTriplets(data.begin(), data.end());
}

int main()
{
    int n = 500;
    SpMat A;
    VectorXd x = VectorXd::Ones(n, 1);
    setup(A, n);
    VectorXd b = A * x;

    Eigen::ConjugateGradient<SpMat> pcg;
    VectorXd x1 = pcg.compute(A).solve(b);
    double err = (x1 - x).norm();
    // cout << "x=" << x.transpose() << endl;
    // cout << "x1=" << x1.transpose() << endl;
    cout << "err=" << err << endl;

    MConjugateGradient cg;
    VectorXd x2 = cg.solve(A, b);
    double err2 = (x2 - x).norm();
    // cout << "x2=" << x2.transpose() << endl;
    cout << "err2=" << err2 << endl;
    return 0;
}