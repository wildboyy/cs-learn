# lab1



```shell
go build -race -buildmode=plugin ../mrapps/wc.go 
```

build 时候警告

```shell
ld: warning: '/private/var/folders/yn/my4xqj9x2p5f7d3tmjmz51km0000gn/T/go-link-1577169792/000000.o' has malformed LC_DYSYMTAB, expected 98 undefined symbols to start at index 1626, found 95 undefined symbols starting at index 1626
```

**这只是警告而已，不影响build的正确性**。

这个警告和`-race`选项相关，`-race`会向代码里插入检测代码，来检测多线程是否会发生竞争条件





```shell
-buildmode=plugin
```

用于将 Go 代码编译成动态链接库（在不同操作系统下表现形式有所不同，例如在 Linux 下是`.so`文件，在 Windows 下是`.dll`文件，在 macOS 下是`.dylib`文件等），使得这些代码可以在其他 Go 程序运行时被动态加载和使用，就像插件一样，为程序提供了一种灵活的扩展机制。