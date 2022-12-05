# ArkInventory_CanIMogIt

Use CanIMogIt in ArkInventory rules to determine if an item can be mogged to help you decide whether to learn an appearance (e.g., by sending it to an alt), or selling an unmoggable item.

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

## altmogged

Returns `true` if you already know this appearance from another source.

Example: `altmogged()`

## icanmog

Returns `true` if you do not know this appearance, and the current character can learn it.

Example: `icanmog()`

## altcanmog

Returns `true` if you do not know this appearance, and another character of yours can learn it.

Example: `altcanmog()`

## cannotmog

Returns `true` if you cannot learn this appearance.

Example: `cannotmog()`

# Example rules

Here are some rules I use with their order:

## Mog: I can learn (order 5000)

Match items that you can learn directly:

```
icanmog()
```

## Mog: alt can learn (order 5000)

Match items that another character can learn that are unbound so you can mail them:

```
not soulbound() and altcanmog()
```

## Mog: already known (order 5900)

Match any appearances you already know directly or from alternate sources.
It does not match items from the latest expansion or in an equipment set, so you do not accidentally sell something you might need:

```
not (expansion() or outfit)
and (mogged() or altmogged())
```

## Mog: cannot mog (order 5999)

Match any appearances that you cannot mog.
It does not match items from the latest expansion or in an equipment set, so you do not accidentally sell something you might need:

```
not (expansion() or outfit())
and cannotmog()
```

# Known Issues

Sometimes the transmog status is not detected correctly; sorry about that, I kinda reverse-engineered how to use the information from CanIMogIt ¯\\_(ツ)_/¯
