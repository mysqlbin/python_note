#!/bin/bash
date      # 默认输出到 stdout, 用 stdout 获取该值
sleep 2
date >&2  # 重定向到stderr即输出到 stderr， 用 stderr 获取该值
exit 1