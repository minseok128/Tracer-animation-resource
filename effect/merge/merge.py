from PIL import Image

def add_transparency(img, opacity):
    """이미지에 투명도를 추가하는 함수"""
    assert 0 <= opacity <= 1, "Opacity must be between 0 and 1"
    
    # 이미지를 RGBA 모드로 변환
    img = img.convert("RGBA")
    # 현재 알파 채널 데이터를 가져옴
    alpha = img.split()[3]
    # 새 알파 채널 생성: 기존 알파 값에 opacity를 곱함
    new_alpha = alpha.point(lambda p: p * opacity)
    # 새 알파 채널을 이미지에 적용
    img.putalpha(new_alpha)
    return img

def merge_images(recall_images, e_images):
    for i, recall_image_path in enumerate(recall_images):
        recall_image = Image.open(recall_image_path).convert('RGBA')
        
        # e 이미지 선택 로직
        if i == 0 or i == 1:
            e_image_path = e_images[0]
        else:
            e_image_index = i - 1
            e_image_index = min(e_image_index, len(e_images) - 1)
            e_image_path = e_images[e_image_index]
        
        e_image = Image.open(e_image_path)
        # e_image에 50% 투명도 추가
        e_image_with_transparency = add_transparency(e_image, 0.75)
        
        # e 이미지를 recall 이미지 사이즈에 맞게 리사이즈
        resized_e_image_with_transparency = e_image_with_transparency.resize(recall_image.size)
        
        # 반대로 합성 순서 변경: e_image 위에 recall_image를 붙임
        # 이 경우, e_image_with_transparency가 기본 레이어가 됨
        # 먼저, e_image의 사본을 생성하여 작업을 시작합니다.
        base_image = Image.new("RGBA", recall_image.size)
        base_image.paste(resized_e_image_with_transparency, (0, 0), resized_e_image_with_transparency)
        
        # 그 위에 recall_image를 붙입니다.
        base_image.paste(recall_image, (0, 0), recall_image)

        # 합성 이미지 저장 또는 보여주기
        output_image_path = f"merged_{i}.png"
        base_image.save(output_image_path)

# 이미지 파일 경로 설정
recall_images = [f"recall_{i}.png" for i in range(24)]
e_images = [f"e_{i}.png" for i in range(22)]

# 이미지 병합 함수 호출
merge_images(recall_images, e_images)
