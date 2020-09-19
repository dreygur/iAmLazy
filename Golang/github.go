package main

/*
 * Not Done Yet
 */

import (
	"encoding/json"
	"fmt"
	"net/http"
)

func create(repoName string) {
	username := "dreygur"
	token := "github"

	createRepo := "https://api.github.com/user/repos"

	headers, err := json.MarshalIndent(map[string]string{
		"Accept": "application/vnd.github.v3+json",
	}, "", "\t")

	if err != nil {
		fmt.Println("JSON Error!")
	}

	body, err := json.MarshalIndent(map[string]string{
		"name":    repoName,
		"private": "false",
	}, "", "\t")

	http.Post(createRepo, "application/x-www-form-urlencoded", &buf)

}

func main() {
	fmt.Println("Hello")
}
