#!/bin/bash

# 대상 디렉토리 목록
SOURCE_DIRS=("flash_pixelated_xpm" "hand_attack_pixelated_xpm" "pulse_pixelated_xpm" "recall_pixelated_xpm" \
"reload_pixelated_xpm" "shot_pixelated_xpm" "walk_pixelated_xpm")

# 각 디렉토리를 순회
for DIR in "${SOURCE_DIRS[@]}"; do
    echo "Processing directory: $DIR"
    # 해당 디렉토리 내의 모든 XPM 파일에 대하여 반복
    for FILE in "$DIR"/*.xpm; do
        # 파일이 존재하는지 확인
        if [ -f "$FILE" ]; then
            echo "Processing file: $FILE"
            # sed를 사용하여 파일 내부의 "#FFCD75" 문자열을 "None"으로 대체
            sed -i 's/#FFCD75/None/g' "$FILE"
        else
            echo "No XPM files found in $DIR."
        fi
    done
done

echo "모든 파일 처리 완료."
