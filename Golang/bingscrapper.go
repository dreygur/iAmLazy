package main

// On process

import (
	"context"
	"log"
	"strings"

	"github.com/gocolly/colly"
	"github.com/imroc/req"
)

// result
type result struct {
	// Rank
	Rank string `json:"rank"`
	// URl
	URL string `json:"url"`
	// Title
	Title string `json:"title"`
}

// searchOptions Modifies how the search behaves
type searchOptions struct {
	// Language Code
	// eg: 'us'
	LanguageCode string
	// Lmits to maximum number of results to fetch
	Limit int
	// UserAgent sets the UserAgent of the http request.
	// Default: "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/61.0.3163.100 Safari/537.36"
	UserAgent string
}

// Search returns a list of search results from Google.
func search(ctx context.Context, searchTerm string, opts ...searchOptions) ([]result, error) {
	c := colly.NewCollector(colly.MaxDepth(1))
	if len(opts) == 0 {
		opts = append(opts, SearchOptions{})
	}

	if opts[0].UserAgent == "" {
		c.UserAgent = "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/61.0.3163.100 Safari/537.36"
	} else {
		c.UserAgent = opts[0].UserAgent
	}

	var lc string
	if opts[0].LanguageCode == "" {
		lc = "en"
	} else {
		lc = opts[0].LanguageCode
	}

	results := []Result{}
	var rErr error
	rank := 1

	c.OnRequest(func(r *colly.Request) {
		if err := ctx.Err(); err != nil {
			r.Abort()
			rErr = err
			return
		}
	})

	c.OnError(func(r *colly.Response, err error) {
		rErr = err
	})

	c.OnHTML("div.g", func(e *colly.HTMLElement) {

		sel := e.DOM

		for i := range sel.Nodes {
			if err := ctx.Err(); err != nil {
				rErr = err
				return
			}

			item := sel.Eq(i)

			rDiv := item.Find("div.r")

			linkHref, _ := rDiv.Find("a").Attr("href")
			linkText := strings.TrimSpace(linkHref)
			titleText := strings.TrimSpace(rDiv.Find("h3").Text())

			sDiv := item.Find("div.s")

			descText := strings.TrimSpace(sDiv.Find("span.st").Text())

			if linkText != "" && linkText != "#" {
				result := Result{
					Rank:        rank,
					URL:         linkText,
					Title:       titleText,
					Description: descText,
				}
				results = append(results, result)
				rank += 1
			}
		}
	})

	url := url(searchTerm, opts[0].CountryCode, lc, opts[0].Limit, opts[0].Start)
	c.Visit(url)

	if rErr != nil {
		return nil, rErr
	}
	return results, nil
}

func main() {
	dork := "inurl:.php?"
	target := "https://www.bing.com/search?q="
	res, err := req.Get(target + dork)
	if err != nil {
		log.Println(err)
	}

	log.Println(res)

	log.Print("Hello")
}
