# UCD Library Media Utils 

This is a collection of scripts and utilities for working with media files in the UCD Library.  Currently the following applications are bundled:

  - tesseract: OCR (Optical Character Recognition) for PDFs/Images
    - CLI docs: https://tesseract-ocr.github.io/tessdoc/Command-Line-Usage.html
  - ffmpeg: Video/Audio transcoding
    - CLI docs: https://ffmpeg.org/ffmpeg.html
  - imagemagick: Image manipulation
    - Convert CLI docus: https://imagemagick.org/script/convert.php 

# Local Usage

Assuming you have a local pdf file named `test.pdf` in your current directory, you can run the following command to OCR the file:

```
docker run \
  -w /data \
  --rm \
  -v $(pwd):/data \
  gcr.io/ucdlib-pubreg/media-utils:latest \
  tesseract test.pdf test --dpi 300 -l eng --psm 1 --oem 3 hocr
```

Here is another example resizing an image:

```
docker run \
  -w data \
  --rm \
  -v $(pwd):/data \
  gcr.io/ucdlib-pubreg/media-utils:latest \
  convert test.png -resize 50% test_50.png
```

# Server 

TODO
