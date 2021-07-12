#pragma once

#include <eigen3/Eigen/Eigen>

void lu(const Eigen::MatrixXd &A, Eigen::MatrixXd &L, Eigen::MatrixXd &U)
{
    using namespace Eigen;

    int n = A.rows();
    assert(A.rows() == A.cols() && "Input matrix A must be square!");
    L = MatrixXd::Identity(n, n);
    U = A;
    for (int j = 0; j < n - 1; ++j)
    {
        for (int i = j + 1; i < n; ++i)
        {
            if (std::abs(U(j, j)) < EPS)
            {
                printf("pivot should not be 0!\n");
                return;
            }

            double mult = U(i, j) / U(j, j);
            L(i, j) = mult;
            for (int k = 0; k <= j; ++k)
            {
                U(i, k) = 0;
            }
            for (int k = j + 1; k < n; ++k)
            {
                U(i, k) = U(i, k) - mult * U(j, k);
            }
        }
    }
}