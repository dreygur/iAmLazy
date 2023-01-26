package main

import (
	"fmt"
	"image"
	"image/color"
	"image/jpeg"
	"image/png"
	"os"
	"strings"
)

func loadImage(filePath string) (image.Image, error) {
	ext := strings.Split(filePath, ".")
	f, err := os.Open(filePath)
	if err != nil {
		return nil, err
	}
	defer f.Close()

	if ext[len(ext)-1] == "jpeg" {
		image, err := jpeg.Decode(f)
		return image, err
	} else if ext[len(ext)-1] == "png" {
		image, err := png.Decode(f)
		return image, err
	}

	return nil, fmt.Errorf("Only JPEG and PNG images are supported")
}

func grayscale(c color.Color) int {
	r, g, b, _ := c.RGBA()
	return int(0.299*float64(r) + 0.587*float64(g) + 0.114*float64(b))
}

func avgPixel(img image.Image, x, y, w, h int) int {
	cnt, sum, max := 0, 0, img.Bounds().Max
	for i := x; i < x+w && i < max.X; i++ {
		for j := y; j < y+h && j < max.Y; j++ {
			sum += grayscale(img.At(i, j))
			cnt++
		}
	}
	return sum / cnt
}

func main() {
	args := os.Args[1:]

	img, err := loadImage(args[0]) // Or pass the image to load as string
	if err != nil {
		panic(err)
	}
	ramp := " .=+#@"
	max := img.Bounds().Max
	scaleX, scaleY := 10, 5
	for y := 0; y < max.Y; y += scaleX {
		for x := 0; x < max.X; x += scaleY {
			c := avgPixel(img, x, y, scaleX, scaleY)
			fmt.Print(string(ramp[len(ramp)*c/65536]))
			// time.Sleep(time.Millisecond * 10)
		}
		fmt.Println()
	}
}
