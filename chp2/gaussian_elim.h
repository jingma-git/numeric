#pragma once
#include "constants.h"
#include "macros.h"
#include <eigen3/Eigen/Eigen>
using namespace Eigen;

void naive_gaussian(const Eigen::MatrixXd &A, const Eigen::VectorXd &rhs, Eigen::VectorXd &x)
{
    int m = A.rows();
    int n = A.cols();

    MatrixXd a = A;
    VectorXd b = rhs;

    // elimination
    for (int j = 0; j < n - 1; ++j)
    {
        if (std::abs(a(j, j) < EPS))
        {
            printf("Zero pivot encountered\n");
            return;
        }

        for (int i = j + 1; i < m; ++i)
        {
            double mult = a(i, j) / a(j, j);
            for (int k = j + 1; k < n; ++k)
            {
                a(i, k) = a(i, k) - mult * a(j, k);
            }
            b(i) = b(i) - mult * b(j);
        }
    }

    std::cout << "A" << std::endl;
    std::cout << a << std::endl;
    std::cout << "b" << std::endl;
    std::cout << b.transpose() << std::endl;

    // back substitute
    x = b;
    for (int i = m - 1; i >= 0; --i)
    {
        for (int j = i + 1; j < n; ++j)
        {
            b(i) = b(i) - a(i, j) * x(j);
        }
        x(i) = b(i) / a(i, i);
    }
}