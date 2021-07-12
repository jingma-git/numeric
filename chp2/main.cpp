#include "gaussian_elim.h"
#include "lu.h"
#include <iostream>
using namespace std;

void test_data0(MatrixXd &A, VectorXd &b)
{
    A.resize(3, 3);
    A << 2, -2, -1,
        4, 1, -2,
        -2, 1, -1;
    b.resize(3, 1);
    b << -2, 1, -3;
}

void test_data1(MatrixXd &A, VectorXd &b)
{
    A.resize(3, 3);
    A << 1, 2, -1,
        0, 3, 1,
        2, -1, 1;
    b.resize(3, 1);
    b << 2, 4, 2;
}

void test_data2(MatrixXd &A, VectorXd &b)
{
    A.resize(3, 3);
    A << 3, 1, 2,
        6, 3, 4,
        3, 1, 5;
    b.resize(3, 1);
    b << 2, 4, 2;
}

int main()
{
    MatrixXd A;
    VectorXd b, x;
    // test_data0(A, b);
    // test_data1(A, b);
    // naive_gaussian(A, b, x);
    // cout << "sol=" << x.transpose() << endl;

    test_data2(A, b);
    // Eigen::PartialPivLU<MatrixXd> LU(A);
    // MatrixXd L = MatrixXd::Identity(A.rows(), A.cols());
    // L.triangularView<Eigen::StrictlyLower>() = LU.matrixLU();
    // MatrixXd U = LU.matrixLU().triangularView<Upper>();

    MatrixXd L, U;
    lu(A, L, U);

    cout << "L:" << endl;
    cout << L << endl;
    cout << "U:" << endl;
    cout << U << endl;
    cout << "L*U" << endl;
    cout << L * U << endl;
    return 0;
}