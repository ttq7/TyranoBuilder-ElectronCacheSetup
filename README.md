# TyranoBuilder Electron 缓存加速脚本
**用于加速 TyranoBuilder Windows 游戏打包，自动配置 Electron 本地缓存，告别重复下载**

---

## 📌 项目介绍
本脚本专为 **TyranoBuilder** 游戏引擎设计，自动从国内镜像下载 Electron 并配置本地缓存，让 Windows 平台打包**秒速完成**，不再长时间等待下载。

- 版本：**1.0**
- 日期：**2026-04-26**
- 系统：**Windows 专用**
- 用途：**TyranoBuilder 游戏打包加速**

---

## ✨ 功能特性
- ✅ 自动下载 **Electron 24.2.0 (win32-x64)**
- ✅ 使用国内镜像，下载速度更快
- ✅ 一键配置 Electron 本地缓存目录
- ✅ 自动设置 `ELECTRON_MIRROR` 环境变量
- ✅ 文件完整性校验
- ✅ 自动清理临时文件
- ✅ 无需手动配置，一键运行

---

## 📋 系统要求
- Windows 系统（Windows_NT）
- PowerShell 5.0 及以上
- 建议 **以管理员身份运行**
- 可正常访问网络

---

## 📁 文件结构
```
项目文件夹/
├─ electron_cache_setup.ps1    # 主脚本（PowerShell）
├─ run.bat                     # 启动脚本（双击运行）
├─ run.txt                     # 安装完成标记
└─ README.md                   # 说明文档
```

---

## 🚀 使用步骤
1. 将所有文件放在**同一个文件夹**
2. **右键 run.bat → 以管理员身份运行**
3. 等待脚本自动执行：
   - 检查系统环境
   - 下载 Electron
   - 配置缓存
   - 设置环境变量
4. 出现 `Operation completed!` 即**安装成功**

---

## 🎯 完成效果
- Electron 已缓存：`%APPDATA%\electron\Cache\`
- 环境变量已配置：`ELECTRON_MIRROR = https://npmmirror.com/mirrors/electron/`
- 打开 TyranoBuilder 打包 Windows 游戏
- **不再重复下载 Electron，打包速度大幅提升**

---

## ⚠️ 注意事项
- 必须**管理员权限**运行，否则环境变量配置失败
- 若环境变量不生效，请**重启电脑**
- 下载失败可重新运行脚本
- 仅支持 **64位 Windows** 系统

---

## 🛠️ 常见问题
**Q：提示“下载失败”**
A：检查网络，重新运行脚本即可。

**Q：提示“权限不足”**
A：右键 run.bat → 以管理员身份运行。

**Q：打包还是很慢/仍在下载**
A：重启 TyranoBuilder 或电脑，确保环境变量生效。
