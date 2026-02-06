#include <cstdlib>
#include <exception>
#include <iostream>

#include "XAdapter.hpp"

using namespace xkl;

int main() {
  try {
    XAdapter adapter;
    std::cout << adapter.get_keyboard_layout_symbol() << std::endl;
  } catch (const std::exception &ex) {
    if (ex.what() != nullptr) {
      std::cout << ex.what() << std::endl;
      exit(EXIT_FAILURE);
    }
  }
  exit(EXIT_SUCCESS);
}
