#include <Eigen/Sparse>
#include <Eigen/Dense>
#include <iostream>
#include <QImage>
using namespace Eigen;
using namespace std;

typedef Eigen::Triplet<double> T;

void insertCoeff(int id, int i, int j, int w, std::vector<T> &coeffs,
                 Eigen::VectorXd &b, const Eigen::VectorXd &boundary)
{
    int n = static_cast<int>(boundary.size());
    int id1 = i + j * n;
    if (i == -1 || i == n) // bottom/top
    {
        b(id) -= w * boundary(j);
    }
    else if (j == -1 || j == n) // left/right
    {
        b(id) -= w * boundary(i);
    }
    else
    {
        coeffs.push_back(T(id, id1, w));
    }
}

void buildProblem(std::vector<T> &coeffs, VectorXd &b, int n)
{
    b.setZero();
    Eigen::ArrayXd boundary = Eigen::ArrayXd::LinSpaced(n, 0, M_PI).sin().pow(2);

    for (int j = 0; j < n; ++j)
    {
        for (int i = 0; i < n; ++i)
        {
            int id = i + j * n;
            insertCoeff(id, i - 1, j, -1, coeffs, b, boundary);
            insertCoeff(id, i + 1, j, -1, coeffs, b, boundary);
            insertCoeff(id, i, j - 1, -1, coeffs, b, boundary);
            insertCoeff(id, i, j - 1, -1, coeffs, b, boundary);
            insertCoeff(id, i, j, 4, coeffs, b, boundary);
        }
    }
}

void saveAsBitmap(const Eigen::VectorXd &x, int n, const char *filename)
{
    Eigen::Array<unsigned char, Eigen::Dynamic, Eigen::Dynamic> bits = (x * 255).cast<unsigned char>();
    QImage img(bits.data(), n, n, QImage::Format_Indexed8);
    img.setColorCount(256);
    for (int i = 0; i < 256; i++)
        img.setColor(i, qRgb(i, i, i));
    img.save(filename);
}

int main()
{
    int n = 300; // img size
    int m = n * n;

    std::vector<T> coeffs;
    VectorXd b(m);
    buildProblem(coeffs, b, n);

    SparseMatrix<double> A(m, m);
    A.setFromTriplets(coeffs.begin(), coeffs.end());

    Eigen::SimplicialCholesky<SparseMatrix<double>> chol;
    chol.compute(A);
    VectorXd x = chol.solve(b);
    saveAsBitmap(x, n, "poisson.png");
    return 0;
}