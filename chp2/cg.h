#pragma once
#include <Eigen/Eigen>
#include <iostream>
using namespace std;
// ConjugateGradient with Jacobian (inverse diagnal) preconditioner
// my implementation is extremely slow!!! still doesn't know why
class MConjugateGradient
{
public:
    Eigen::VectorXd solve(const Eigen::SparseMatrix<double> &A, const Eigen::VectorXd &b)
    {
        using namespace Eigen;
        int n = A.rows();
        VectorXd M = A.diagonal();
        VectorXd x0 = VectorXd::Zero(n);
        VectorXd r0 = b - A * x0;
        VectorXd z0 = r0.array() / M.array();
        VectorXd d0 = z0;
        VectorXd x1 = x0;
        VectorXd r1 = r0;
        VectorXd z1 = z0;
        VectorXd d1 = d0;
        int k = 0;
        for (;; ++k)
        {
            cout << "iter" << k << " r0:" << r0.cwiseAbs().maxCoeff() << endl;
            if (r0.cwiseAbs().maxCoeff() < 1e-6)
                break;
            Eigen::VectorXd Ad0 = A * d0;
            double alpha = r0.dot(z0) / Ad0.dot(d0);
            x1 = x0 + alpha * d0;
            r1 = r0 - alpha * Ad0;
            z1 = r1.array() / M.array();
            double beta = r1.dot(r1) / r0.dot(r0);
            d1 = r1 + beta * d0;

            x0 = x1;
            r0 = r1;
            z0 = z1;
            d0 = d1;
        }
        cout << "iteration " << k << endl;
        return x0;
    }
};