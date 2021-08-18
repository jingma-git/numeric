#pragma once
#include <Eigen/Eigen>

double cond(const Eigen::MatrixXd& A){
using namespace Eigen;
    JacobiSVD<MatrixXd> svd(A);
return  svd.singularValues()(0) 
    / svd.singularValues()(svd.singularValues().size()-1);
}