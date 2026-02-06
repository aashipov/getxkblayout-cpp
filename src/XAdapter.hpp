#include <iterator>
#include <regex>
#include <string>
#include <vector>

namespace xkl {

class XAdapter {

public:
  XAdapter();
  ~XAdapter();
  std::string get_keyboard_layout_symbol();

private:
  uint _groupCount;
  std::vector<std::string> _symbolNames;

  static std::vector<std::string> split(const std::string str,
                                        const std::string delimiter) {
    const std::regex re(delimiter);
    return std::vector<std::string>(
        std::sregex_token_iterator{begin(str), end(str), re, -1},
        std::sregex_token_iterator{});
  }
};

} // namespace xkl
