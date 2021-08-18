#pragma once
#include <eigen3/Eigen/Eigen>

class M_LLT
{
public:
    void compute(const Eigen::MatrixXd &mat)
    {
        A = mat;
        int n = A.rows();
        int m = A.cols();
        assert(n == m && "matrix must be square! SPD");

        R = MatrixXd::Zero(n, n);
        for (int i = 0; i < n; ++i)
        {
            R(i, i) = std::sqrt(A(i, i));
            for (int j = i + 1; j < n; ++j)
            {
                R(i, j) = A(i, j) / R(i, i);
            }
            RowVectorXd u = R.block(i, i + 1, 1, (n - i - 1));
            MatrixXd A1 =  u.transpose() * u;
            A.block(i + 1, i + 1, (n - i - 1), (n - i - 1)).array() -= A1.array();
        }

        std::cout << "R" << "\n" << R << std::endl;
    }

private:
    Eigen::MatrixXd A; // A = R' * R
    Eigen::MatrixXd R;
};