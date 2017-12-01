# 📖 Readme

You will need [emojicode](http://www.emojicode.org) installed.

## 🏗️ Building

Build using make, it will run `emojicodec` (the emojicode compiler) to compile each emojic source file into
emojib binaries.
```
make
```

Running compiled program:
```
emojicode 1️.emojib
```

## 💉 Tests

Tests are run using [bats](https://github.com/sstephenson/bats)
```
make test
```
