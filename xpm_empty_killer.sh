#!/bin/bash

# 대상 디렉토리 목록
SOURCE_DIRS=("flash_final" "hand_attack_final" "pulse_final" "recall_final" \
"reload_final" "shot_final" "walk_final")

# 각 디렉토리를 순회
for DIR in "${SOURCE_DIRS[@]}"; do
    echo "Processing directory: $DIR"
    
    # 새로운 디렉토리 이름을 생성 (예: flash_final -> flash)
    NEW_DIR="${DIR%_final}"
    
    # 새로운 디렉토리가 없으면 생성
    [ ! -d "$NEW_DIR" ] && mkdir -p "$NEW_DIR"
    
    # 해당 디렉토리 내의 모든 XPM 파일에 대하여 반복
    for FILE in "$DIR"/*.xpm; do
        # 파일이 존재하는지 확인
        if [ -f "$FILE" ]; then
            echo "Processing file: $FILE"
            # 새로운 파일 경로 생성
            NEW_FILE="${FILE/$DIR/$NEW_DIR}"
            # empty_killer 명령을 실행하여 결과를 새로운 파일에 저장
            ./empty_killer < "$FILE" > "$NEW_FILE"
        else
            echo "No XPM files found in $DIR."
        fi
    done
done

echo "모든 파일 처리 완료."
