# UCD Library DAMS Usage

Here are some sample products and relating scripts to get you started using this media-utils container.

All examples are just the raw commands that would be run in the container.  You will need to prefix them with the `docker run` command found in the README.md file.

## Image Conversion

Resize and convert images to JPEGs.  This example uses the `convert` command from ImageMagick and keeps the aspect ratio of the original image ensuring widths of certain sizes are met.

Create a 256px wide JPEG

```bash
convert original.tif -resize 256x -quality 90 -alpha remove -layers flatten small.jpg
```

Create a 512px wide JPEG

```bash
convert original.tif -resize 521x -quality 90 -alpha remove -layers flatten medium.jpg
```

Create a 1024px wide JPEG.  Note, this version includes a deskew operation to straighten the image before resizing.

```bash
convert original.tif -resize 1024x -deskew 40% -fill black -alpha remove -quality 90 -layers flatten large.jpg
```

Create a large JPEG for running the OCR step over.

```bash
convert -density 300 original.tif -alpha remove -fill black -fuzz 80% +opaque "#FFFFFF" -deskew 40% -filter catrom -layers flatten -quality 100 -resize 2048x ocr.jpg
```

Identify the size of an image.  This is useful for sending along to the DAMS client UI so it can layout the image properly.

```bash
identify -format "%wx%h larger.jpg
```

## OCR

Run OCR on a JPEG image.  This example uses output from the Imagemagik OCR jpg and sends the file the `tesseract` command from Tesseract and outputs a hOCR file.

```bash
tesseract ocr.jpg ocr --dpi 300 -l eng --psm 1 --oem 3 hocr
```

## Video Conversion

Complicated :)  See the dams [convert.sh script](https://github.com/ucd-library/dams/blob/main/services/image-utils/lib/ffmpeg/convert.sh) for an example of how to convert a video to a web friendly format with adaptive bitrate streaming.