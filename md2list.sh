#!/bin/bash
# 文件夹内md多个文件列表生成器  仅限同一级目录下
ls | grep -v list.md | grep -v READMEList.sh | xargs -I{} echo "* ["{}"](./"{}")" > list.md