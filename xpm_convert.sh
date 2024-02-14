#!/bin/bash

# 변환할 이미지가 있는 원본 디렉토리 목록
SOURCE_DIRS=("flash_pixelated" "hand_attack_pixelated" "pulse_pixelated" "recall_pixelated" \
    "reload_pixelated" "shot_pixelated" "walk_pixelated")

# 원본 디렉토리 목록을 순회
for DIR in "${SOURCE_DIRS[@]}"; do
    echo "Processing directory: $DIR"
    TARGET_DIR="${DIR}_xpm"
    if [ ! -d "$TARGET_DIR" ]; then
        mkdir "$TARGET_DIR"
    fi
    # 해당 디렉토리에서 PNG 파일을 찾아 XPM으로 변환
    for FILE in "$DIR"/*.png; do
        # 파일이 존재하는지 확인
        if [ -f "$FILE" ]; then
            # 파일 이름 추출 (확장자 제외)
            BASENAME=$(basename "$FILE" .png)
            # 변환 명령 실행
            convert "$FILE" "$TARGET_DIR/$BASENAME.xpm"
        else
            echo "No PNG files found in $DIR."
        fi
    done
done

echo "변환 완료."
