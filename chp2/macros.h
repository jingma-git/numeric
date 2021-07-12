#pragma once

#ifndef M_DEBUG
#include <iostream>
#define M_DEBUG std::cout << __FILE__ << " " << __LINE__ << " "
#endif