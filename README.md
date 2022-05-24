# ArkInventory_CanIMogIt

Use CanIMogIt in ArkInventory rules to determine if an item can be mogged.

# Requirements

- World of Warcraft (Retail)
- [ArkInventory](https://www.wowinterface.com/downloads/info6488-ArkInventory.html)
- [CanIMogIt](https://www.wowinterface.com/downloads/info24015-CanIMogIt.html)

# Usage

The following rule functions can be used to put items on bars.

Note: Check the [ArkInventory documentation](https://github.com/arkayenro/arkinventory/wiki/Rules) on how to use rules, and don't forget to enable the rule and add it to a bar.

## mogged

Returns `true` if you already know this appearance.

Example: `mogged()`

## icanmog

Returns `true` if you do not know this appearance, and the current character can learn it.

Example: `icanmog()`

## altcanmog

Returns `true` if you do not know this appearance, and another character of yours can learn it.

Example: `altcanmog()`

## cannotmog

Returns `true` if you cannot learn this appearance.

Example: `cannotmog()`

# Known Issues

Sometimes the transmog status is not detected correctly; sorry about that, I kinda reverse-engineered how to use CanIMogIt ¯\\_(ツ)_/¯
