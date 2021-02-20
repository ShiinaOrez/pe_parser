# PE Parser

PE Parser 是一个可以在本地解析 PE 文件结构的桌面应用，使用 Dart-Flutter 和 Golang 进行编写，因此可以运行在：Windows、Linux 和 MacOS 系统上。

# 运行
## 开发模式
在保证本地具有 go-flutter 开发环境后（包括 Xcode、Dart、Flutter、Go 以及 hover），使用以下命令启动应用

```
cd pe_parser/ && hover run
```

## 打包
由于打包需要的环境比较复杂，因此最好使用 Docker 进行打包，因此需要保证你的本地运行有 Docker，并保证网络良好。

### Windows

```
hover build windows --docker
```

运行后在 `pe_parser/go/build/outputs/windows` 下即可以运行 `.exe` 可执行文件。若要移植到其他 Windows 操作系统，需要将整个文件夹一起拷贝，因为其中包括了运行依赖的 `flutter_engine.dll` 文件。

### Linux

```
hover build linux-deb --docker
```

运行后在 `pe_parser/go/build/outputs/linux-deb` 下即可以找到 `.deb` 文件以用于安装应用。

### MacOS

```
hover build darwin-dmg --docker
```

运行后在 `pe_parser/go/build/outputs/darwin-dmg` 下即可以找到 `.dmg` 文件以用于安装应用。

## 声明
不得将此应用用于任何商业用途。