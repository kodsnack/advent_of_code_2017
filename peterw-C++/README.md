# How to build

A C++17 compiler is needed. Tested with LLVM clang 5.0 on macOS and Visual Studio 2017 15.5 on Windows.

## Build with Visual Studio 2017 (15.5) in Windows

```
md .build
cd .build
cmake -G"Visual Studio 15 2017 Win64" ..
cmake --build . --target ALL_BUILD --config Release
Day1\Release\\Day1
...
```

## Build with Xcode on macOS

Install a custom toolchain (LLVM clang 5.0) for Xcode. 
With brew:

```brew install --with-toolchain llvm```

Copy /usr/local/Cellar/llvm/5.0.0/Toolchains/LLVM5.0.0.xctoolchain/ to  /Library/Developer/Toolchains/

```
mkdir .build
cd .build
cmake -GXcode ..
cmake --build . --target ALL_BUILD --config Release -- -toolchain org.llvm.5.0.0
Day1/Release/Day1
Day2/Release/Day2
...
```
