# [Hammerspoon](http://www.hammerspoon.org) configuration

* [init](init.lua) - configuration

## Modules

* [cheatsheet](cheatsheet/) - show cheatsheet for the frontmost application's menu
* [dock_press](dock_press/) - bind hotkeys to numbered dock items
* [ensure](ensure/) - request confirmation for application hotkeys
* [layout_cache](layout_cache/) - cache keyboard layout per window

## Framework

### [kit](kit/): utility library

* [[kit/core](kit/core.lua)] `merge` - merge value into accumulator
* [[kit/module](kit/module.lua)] `setup` - setup static module with configuration

### [vhs](vhs.lua): root module

* `{}` - setup root module with configuration
* `[]` - get module by name
