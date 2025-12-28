#!/bin/bash

# 脚本名称：replace_css_refs.sh
# 功能：获取CSS文件名，并在HTML文件中替换new_live*的引用

echo "开始查找并替换CSS引用..."
echo "========================================"

# 计数器
css_count=0
replace_count=0

# 遍历当前目录下所有以ty-qmb开头的文件夹
for folder in ty-qmb*/; do
    # 检查是否是目录
    if [[ -d "$folder" ]]; then
        css_path="${folder}mobile/statics/css"
        views_path="${folder}mobile/views/bifen"
        
        echo ""
        echo "处理项目: $(basename "$folder")"
        echo "----------------------------------------"
        
        # 检查css目录是否存在
        if [[ -d "$css_path" ]]; then
            # 查找new_live开头的css文件
            css_files=()
            while IFS= read -r css_file; do
                css_files+=("$css_file")
            done < <(find "$css_path" -maxdepth 1 -type f -name "new_live*.css" 2>/dev/null)
            
            if [[ ${#css_files[@]} -eq 0 ]]; then
                echo "  未找到new_live开头的CSS文件"
                continue
            fi
            
            for css_file in "${css_files[@]}"; do
                ((css_count++))
                
                # 获取CSS文件名（不含路径）
                css_filename=$(basename "$css_file")
                echo ""
                echo "  处理CSS文件 [$css_count]: $css_filename"
                
                # 检查views目录是否存在
                if [[ ! -d "$views_path" ]]; then
                    echo "    错误: HTML目录不存在 - $views_path"
                    continue
                fi
                
                # 处理每个HTML文件
                for html_file in "list.html" "sc.html" "wc.html"; do
                    html_path="${views_path}/${html_file}"
                    
                    if [[ -f "$html_path" ]]; then
                        echo "    检查HTML文件: $html_file"
                        
                        # 查找所有new_live*的引用
                        ref_count=0
                        
                        # 方法1：使用sed查找并替换
                        # 查找匹配new_live*.css的引用
                        while IFS= read -r line; do
                            # 提取new_live开头的文件名
                            old_ref=$(echo "$line" | grep -o "new_live[^'\"]*\.css" | head -1)
                            if [[ -n "$old_ref" ]]; then
                                ((ref_count++))
                                echo "      找到引用 [$ref_count]: $old_ref"
                                
                                # 替换引用
                                sed -i "s|$old_ref|$css_filename|g" "$html_path"
                                
                                if [[ $? -eq 0 ]]; then
                                    ((replace_count++))
                                    echo "      替换为: $css_filename"
                                else
                                    echo "      错误: 替换失败"
                                fi
                            fi
                        done < <(grep -n "new_live.*\.css" "$html_path")
                        
                        if [[ $ref_count -eq 0 ]]; then
                            echo "      未找到new_live*.css的引用"
                        fi
                        
                    else
                        echo "    跳过: $html_file 不存在"
                    fi
                done
            done
        else
            echo "  CSS目录不存在: $css_path"
        fi
    fi
done

echo ""
echo "========================================"
echo "处理完成！"
echo "共处理 $css_count 个CSS文件"
echo "共进行 $replace_count 次替换"
echo "========================================"