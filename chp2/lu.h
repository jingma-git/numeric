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

// chp2.4 Paritial Pivot LU, select the largest pivot from the rest rows
// PA = LU
class PartialPivotLU
{

public:
    PartialPivotLU(const Eigen::MatrixXd &mat) : A(mat) {}
    const Eigen::MatrixXd &matrixL() const { return L; }
    const Eigen::MatrixXd &matrixU() const { return U; }
    const Eigen::MatrixXd &matrixP() const { return P; }

    void compute() // factorize
    {
        using namespace Eigen;
        int n = A.rows();
        assert(A.rows() == A.cols() && "Input matrix A must be square!");
        MatrixXd a = A;
        P = MatrixXd::Identity(n, n);

        std::cout << "a\n"
                  << a << std::endl;

        for (int j = 0; j < n - 1; ++j)
        {
            for (int i = j + 1; i < n; ++i)
            {
                // select the largest element as pivot from col_j
                double pivot = a(j, j);
                int pi = j;
                for (int k = j + 1; k < n; ++k)
                {
                    if (a(k, j) > pivot)
                    {
                        pivot = a(k, j);
                        pi = k;
                    }
                }
                if (pi != j)
                {
                    P.row(j).swap(P.row(pi));
                    a.row(j).swap(a.row(pi));
                }

                // eliminate pivot by subtract
                double mult = a(i, j) / a(j, j);
                a(i, j) = mult;
                for (int k = j + 1; k < n; ++k)
                {
                    a(i, k) = a(i, k) - mult * a(j, k);
                }
            }
        }

        std::cout << "after a\n"
                  << a << std::endl;
        L = MatrixXd::Identity(n, n);
        L.triangularView<StrictlyLower>() = a.triangularView<StrictlyLower>();
        std::cout << "after L\n"
                  << L << std::endl;
        U = a.triangularView<Upper>();
        std::cout << "after U\n"
                  << U << std::endl;
        std::cout << "after P\n"
                  << P << std::endl;
    }

    Eigen::VectorXd solve(const Eigen::VectorXd &rhs)
    {
        int n = A.rows();
        // L*c = P*rhs
        VectorXd b = P * rhs;
        for (int i = 0; i < n; ++i)
        {
            for (int j = 0; j < i; ++j)
            {
                b(i) -= L(i, j) * b(j);
            }
            b(i) = b(i) / L(i, i);
        }
        std::cout << "c\n"
                  << b.transpose() << std::endl;

        for (int i = n - 1; i >= 0; --i)
        {
            for (int j = n - 1; j > i; --j)
            {
                b(i) -= U(i, j) * b(j);
            }
            b(i) = b(i) / U(i, i);
        }
        std::cout << "x\n"
                  << b.transpose() << std::endl;
        return b;
    }

private:
    Eigen::MatrixXd A;
    Eigen::MatrixXd L;
    Eigen::MatrixXd U;
    Eigen::MatrixXd P;
};