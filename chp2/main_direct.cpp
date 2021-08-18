#include "gaussian_elim.h"
#include "lu.h"
#include "cond.h"
#include "cholesky.h"
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

// eg.2.17
void test_data3(MatrixXd &A, VectorXd &b)
{
    A.resize(3, 3);
    A << 2, 1, 5,
        4, 4, -4,
        1, 3, 1;
    b.resize(3, 1);
    b << 5, 0, 6;
}

void test_data4(MatrixXd& A, VectorXd& b){ // eg 4.2
    A.resize(3, 2);
    A << 1, -4,
    2, 3,
    2, 2;

    b.resize(3, 1);
    b << -3, 15, 9;
}

void test_data5(MatrixXd& A){ 
    A.resize(3, 3);
    A << 4,-2, 2,
    -2, 2, -4,
    2,-4, 11;
}

void test_pplu(){
    MatrixXd A;
    VectorXd b, x;
    // test_data0(A, b);
    // test_data1(A, b);
    // naive_gaussian(A, b, x);
    // cout << "sol=" << x.transpose() << endl;

    // test_data2(A, b);
    test_data3(A, b);
    // Eigen::PartialPivLU<MatrixXd> LU(A); // chp2.4
    // MatrixXd L = MatrixXd::Identity(A.rows(), A.cols());
    // L.triangularView<Eigen::StrictlyLower>() = LU.matrixLU();
    // MatrixXd U = LU.matrixLU().triangularView<Upper>();

    // MatrixXd L, U;
    // lu(A, L, U);

    // cout << "L:" << endl;
    // cout << L << endl;
    // cout << "U:" << endl;
    // cout << U << endl;
    // cout << "L*U" << endl;
    // cout << L * U << endl;

    PartialPivotLU pplu(A);
    pplu.compute();
    x = pplu.solve(b);

    // https://learnaboutstructures.com/Bernoulli-Euler-Beam-Theory
}

void test_cond_number(){
 MatrixXd A;
 VectorXd b;

 test_data4(A, b);
 double cond_num= cond(A);
 cout << "cond=" << cond_num << endl;
 cout << "cond(A'*A)" << cond(A.transpose()*A) << endl;
}

void test_cholesky(){
    Eigen::MatrixXd A;
    test_data5(A);
    M_LLT llt;
    llt.compute(A);
}

int main()
{
    // test_pplu();
    // test_cond_number();
    test_cholesky();
    return 0;
}