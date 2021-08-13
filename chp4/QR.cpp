#include <Eigen/Eigen>
#include <iostream>
using namespace std;
using namespace Eigen;

int main()
{
    MatrixXd A(3, 2);
    A << 1, -4,
        2, 3,
        1, 2;
    VectorXd b(3);
    b << -3, 15, 9;
    HouseholderQR<MatrixXd> qr(3, 2);
    qr.compute(A);
    VectorXd x = qr.solve(b);
    cout << x << endl;
    // normal equation
    cout << "normal equation: " << endl;
    MatrixXd AA = A.transpose() * A;
    MatrixXd Ab = A.transpose() * b;
    cout << AA.llt().solve(Ab) << endl;
    cout << "error" << endl;
    cout << (A * x - b).norm() << endl;
    return 0;
}