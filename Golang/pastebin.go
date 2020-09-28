package main

import (
	"fmt"
	"io/ioutil"
	"log"
	"os"

	"github.com/imroc/req"
)

func check(r error) {
	if r != nil {
		log.Fatal(r)
	}
}

func main() {
	// File
	if len(os.Args) < 2 {
		fmt.Println("[-] Please provide a filename to paste...")
		os.Exit(1)
	}
	file, err := ioutil.ReadFile(os.Args[1])
	check(err)

	// Target
	url := "https://paste.ubuntu.com/"

	// Headers
	headers := req.Header{
		"Host":                      "paste.ubuntu.com",
		"User-Agent":                "Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101 Firefox/68.0",
		"Accept":                    "text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8",
		"Accept-Language":           "en-US,en;q=0.5",
		"Accept-Encoding":           "gzip, deflate, br",
		"Referer":                   "https://paste.ubuntu.com/",
		"Content-Type":              "application/x-www-form-urlencoded",
		"DNT":                       "1",
		"Connection":                "keep-alive",
		"Upgrade-Insecure-Requests": "1",
	}

	data := req.Param{
		"poster":     "Rakibul Yeasin",
		"syntax":     "python3",
		"expiration": "",
		"content":    string(file),
	}

	res, err := req.Post(url, headers, data)
	check(err)
	fmt.Println(res.Request().URL.String())
}
