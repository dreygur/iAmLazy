package main

import (
	"flag"
	"fmt"
	"io/ioutil"
	"log"
	"net/http"
	"net/url"
	"os"
	"strings"
	"time"
)

// Error Checker
func c(r error) {
	if r != nil {
		log.Fatal(r)
	}
}

func main() {
	// Help Message
	flag.Usage = func() {
		h := "Usage: Auto paster on paste.ubuntu.com [OPTIONS] argument ...\n\n"

		h += "Usage:\n"
		h += "  pastebin [NAME] [SYNTAX]\n\n"

		h += "Examples:\n"
		h += "  pastebin pastebin.go\n"
		h += "  pastebin pastebin.go go\n\n"

		fmt.Fprintf(os.Stderr, h)
	}

	// File Reader
	if len(os.Args) < 2 || strings.HasPrefix(os.Args[1], "-") {
		flag.Usage()
		os.Exit(1)
	}
	file, err := ioutil.ReadFile(os.Args[1])
	c(err)

	// Syntax Selection
	var syntax string = "text"
	if len(os.Args) >= 3 && os.Args[2] != "" {
		syntax = os.Args[2]
	}

	// Target
	uri := "https://paste.ubuntu.com/"

	// Header
	headers := map[string]string{
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

	// Post Data
	body := url.Values{
		"poster":     {"Rakibul Yeasin"},
		"syntax":     {syntax},
		"expiration": {""},
		"content":    {string(file)},
	}

	// Making Request
	client := &http.Client{Timeout: time.Second * 3600}
	req, err := http.NewRequest("POST", uri, strings.NewReader(body.Encode()))
	c(err)

	// Adding Headers Dynamically
	for k, v := range headers {
		req.Header.Add(k, v)
	}

	res, err := client.Do(req)
	c(err)
	// The Final Paste URL
	fmt.Println(res.Request.URL)
}
