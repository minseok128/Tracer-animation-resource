#!/bin/bash

# 대상 디렉토리 목록
SOURCE_DIRS=("flash_final" "hand_attack_final" "pulse_final" "recall_final" \
"reload_final" "shot_final" "walk_final")

# 각 디렉토리를 순회
for DIR in "${SOURCE_DIRS[@]}"; do
    echo "Processing directory: $DIR"
    # 해당 디렉토리 내의 모든 XPM 파일에 대하여 반복
    for FILE in "$DIR"/*.xpm; do
        # 파일이 존재하는지 확인
        if [ -f "$FILE" ]; then
            echo "Processing file: $FILE"
            # macOS/BSD sed를 사용하여 파일 내부의 "#38B764" 문자열을 "None"으로 대체
            sed -i '' 's/#38B764/None/g' "$FILE"
        else
            echo "No XPM files found in $DIR."
        fi
    done
done

echo "모든 파일 처리 완료."
