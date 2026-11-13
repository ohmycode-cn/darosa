# DAROSA BASH STYLE GUIDE

本指南是 DAROSA 项目中所有 Bash 脚本（`*.sh`）必须遵守的命名、注释与格式规范。
变量、常量、函数的命名与作用域遵循本指南，注释（注解）统一使用
Google Shell Style Guide 的 Bash Shell 注释风格。

| 对象 | 定义位置 | 命名风格 | 开放（跨文件） | 私有（仅当前文件） |
| ---- | ---- | ---- | ---- | ---- |
| 变量 | 仅函数体内部 | 全小写 + 下划线 | — | `var_name` |
| 常量 | 仅函数体外部 | 全大写 | `CONST_NAME` | `__CONST_NAME__` |
| 函数 | 函数体外部 | 大驼峰 | `function FunctionName() {}` | `function __FunctionName__() {}` |

| 格式 | 要求 | 控制信息 |
| ---- | ---- | ---- |
| 列限制 | 每行不超过 80 列 | `lim/std/COL.LIMIT` |
| 缩进 | 4 个空格 | `lim/std/CHR.LIMIT` |
| Tab | 禁止 Tab 字符，仅允许空格字符 | `lim/std/CHR.LIMIT` |

## 1. 变量（Variable）

- 变量**仅允许**定义在函数体内部，禁止在函数体外部定义变量。
- 命名风格：全小写字符，可与下划线组合（snake_case）。
- 函数内声明变量时使用 `local` 限定作用域。

```bash
function BuildTarget() {
    local target_name="$1"
    local build_mode="${2:-release}"
    local output_file=""
    ...
}
```

## 2. 常量（Constant）

- 常量**仅允许**定义在函数体外部，禁止在函数体内部定义常量。
- 命名风格：全大写字符（UPPER_CASE）。
- 常量建议使用 `readonly` 修饰。

| 类型 | 格式 | 访问范围 |
| ---- | ---- | ---- |
| 开放常量 | `CONST_NAME` | 当前文件及其他文件均可访问 |
| 私有常量 | `__CONST_NAME__` | 仅当前文件可访问，其他文件不可访问 |

```bash
# 开放常量：其他文件可通过 source 引入后访问
readonly DEFAULT_TIMEOUT=30

# 私有常量：双下划线包裹，其他文件不可访问
readonly __MAX_RETRY_COUNT__=5
```

私有常量以双下划线包裹作为文件私有标识。其他文件通过 `source` 引入本文件后，
不得读取或修改任何 `__CONST_NAME__` 形式的常量。

## 3. 函数（Function）

- 函数命名风格：大驼峰（PascalCase），每个单词首字母大写。
- 定义时必须使用 `function` 关键字与 `()`。

| 类型 | 格式 | 访问范围 |
| ---- | ---- | ---- |
| 开放函数 | `function FunctionName() {}` | 可被其他文件调用 |
| 私有函数 | `function __FunctionName__() {}` | 仅当前文件内部使用 |

```bash
# 开放函数：其他文件可通过 source 引入后调用
function GetVersion() {
    ...
}

# 私有函数：双下划线包裹，其他文件不可调用
function __ValidateInput__() {
    ...
}
```

私有函数以双下划线包裹作为文件私有标识。其他文件通过 `source` 引入本文件后，
不得调用任何 `__FunctionName__` 形式的函数。

## 4. 注释（Comment）

函数注解与变量注解统一使用 Google Shell Style Guide 的注释风格：

- `#` 后保留一个空格；
- 注解使用完整句子，句末使用句号；
- 函数注解紧贴函数定义上方，变量注解紧贴变量上一行或使用行内注释。

### 4.1 函数注解

函数注解采用 Google 风格的函数头注释，由 `#######################################`
包围，依次包含：函数描述、`Globals:`、`Arguments:`、`Outputs:`、`Returns:` 小节。
各小节名独占一行，条目逐行列出并缩进两个空格。

```bash
#######################################
# 压缩指定的图片文件。
# Globals:
#   DEFAULT_QUALITY
# Arguments:
#   image_file: 待压缩的图片文件路径。
#   output_dir: 可选。输出目录，默认为当前目录。
# Outputs:
#   将压缩后的文件路径写入标准输出。
# Returns:
#   0 表示成功，非 0 表示失败。
#######################################
function CompressImage() {
    local image_file="$1"
    local output_dir="${2:-.}"
    ...
}
```

小节说明：

| 小节 | 含义 |
| ---- | ---- |
| （描述） | 函数用途说明，紧贴函数头首行下方 |
| `Globals:` | 函数读取或修改的函数体外部开放常量列表 |
| `Arguments:` | 参数列表，每个参数一行；无参数时写 `None` |
| `Outputs:` | 输出到 STDOUT 或 STDERR 的内容 |
| `Returns:` | 返回值（除最后一条命令默认退出码之外的返回语义） |

`Globals:`、`Outputs:`、`Returns:` 小节按需省略，`Arguments:` 始终保留。

### 4.2 变量注解

变量（含常量）注解同样使用 Google 注释风格，采用紧贴变量上一行的注释或行内注释：

```bash
function CompressImage() {
    local image_file="$1" # 待压缩的图片文件路径
    # 压缩质量，取值范围 1-100。
    local quality=85
    ...
}
```

```bash
# 默认压缩质量，取值范围 1-100。
readonly DEFAULT_QUALITY=85

# 重试上限，仅本文件内部使用。
readonly __MAX_RETRY_COUNT__=5
```

## 5. 列限制（Column Limit）

- 标准控制信息：`lim/std/COL.LIMIT`。
- 每行最大列宽为 **80 列**，缩进与注释均计入列宽。
- 任何一行不得超过 80 列；超长字符串使用换行符 `\` 延续或
  here document 拆分为多行。

## 6. 缩进与 Tab（Indentation and Tab）

- 标准控制信息：`lim/std/CHR.LIMIT`。
- 缩进宽度：**4** 个空格。
- Tab 宽度：**4**。
- **禁止使用 Tab 字符，仅允许使用空格字符。**

## 7. 完整示例

```bash
#!/bin/bash

# 开放常量
readonly APP_NAME="darosa"

# 私有常量
readonly __DEFAULT_SUFFIX__=".bak"

#######################################
# 打印应用版本信息。
# Globals:
#   APP_NAME
# Outputs:
#   将 "<APP_NAME> version <version>" 写入标准输出。
#######################################
function PrintVersion() {
    # 版本号，三段式。
    local version="1.0.0"
    echo "${APP_NAME} version ${version}"
}

#######################################
# 为指定文件创建备份。
# Globals:
#   __DEFAULT_SUFFIX__
# Arguments:
#   file_path: 待备份的文件路径。
# Returns:
#   0 表示成功，1 表示文件不存在。
#######################################
function BackupFile() {
    local file_path="$1"
    if [[ ! -f "${file_path}" ]]; then
        return 1
    fi
    __CopyFile__ "${file_path}" "${file_path}${__DEFAULT_SUFFIX__}"
}

#######################################
# 复制文件到目标路径。
# Arguments:
#   src_path: 源文件路径。
#   dst_path: 目标文件路径。
#######################################
function __CopyFile__() {
    local src_path="$1"
    local dst_path="$2"
    cp "${src_path}" "${dst_path}"
}

PrintVersion
BackupFile "./README.MD"
```
