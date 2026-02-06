#include <stdexcept>

#include <X11/XKBlib.h>
#include <X11/Xlib.h>
#include <X11/extensions/XKBrules.h>

#include "XAdapter.hpp"

namespace xkl {

XAdapter::XAdapter() {
  XkbIgnoreExtension(False);
  Display *dpy = XOpenDisplay(NULL);
  if (dpy == nullptr) {
    throw std::runtime_error("Cannot open display");
  }

  XkbStateRec state;
  XkbGetState(dpy, XkbUseCoreKbd, &state);

  XkbRF_VarDefsRec vd;
  XkbRF_GetNamesProp(dpy, nullptr, &vd);
  XCloseDisplay(dpy);

  _symbolNames = split(vd.layout, ",");
  _groupCount = state.group;
  if (_groupCount > _symbolNames.size()) {
    throw std::runtime_error("Symbol count does not match groups count");
  }
}
XAdapter::~XAdapter() {}

std::string XAdapter::get_keyboard_layout_symbol() {
  return _symbolNames.at(_groupCount);
}

} // namespace xkl
