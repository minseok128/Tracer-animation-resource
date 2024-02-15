from PIL import Image
import glob

# 현재 디렉토리의 모든 XPM 파일에 대해 반복
for xpm_file in glob.glob('*.xpm'):
    # 이미지를 열고
    with Image.open(xpm_file) as img:
        # 동일한 이름으로 PNG 형식으로 저장 (확장자만 변경)
        png_filename = xpm_file.rsplit('.', 1)[0] + '.png'
        img.save(png_filename)
        print(f"Converted {xpm_file} to {png_filename}")

