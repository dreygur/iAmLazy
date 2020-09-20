package main

/*
 * Auto git repo create and initiator on local
 * Author: Rakibul Yeasin (@dreygur)
 */

import (
	b64 "encoding/base64"
	"encoding/json"
	"flag"
	"fmt"
	"log"
	"os"
	"os/exec"

	"github.com/imroc/req"
)

func create(repoName string, private bool) {
	username := "" // Github Username
	token := ""    // Github Personal Auth-Token

	// HTTP-Auth (base64)
	userToken := username + ":" + token
	auth := "Basic " + b64.StdEncoding.EncodeToString([]byte(userToken))

	// Github api to create a repo
	createRepo := "https://api.github.com/user/repos"

	// Headers
	header := req.Header{
		"Accept":        "application/vnd.github.v3+json",
		"Authorization": auth,
	}

	// Is it a Private Repo or Not
	prv := "false"
	if private {
		prv = "true"
	}

	// Basic commands to Create the repo as body JSON
	body, _ := json.Marshal(map[string]string{
		"name":    repoName,
		"private": prv,
	})

	// Getting just the JSON response
	req.SetFlags(req.LrespBody)
	res, err := req.Post(createRepo, header, body)
	if err != nil {
		log.Fatal(err)
	}
	var dest map[string]interface{}
	res.ToJSON(&dest)
	if dest["ssh_url"] != nil {
		fmt.Printf("[+] SSH URL: %+v\n", dest["ssh_url"])
		_, err = os.Stat(repoName)
		if err != nil {
			// Creating Directory with Write-Execution Mode and changing path to that
			os.MkdirAll(repoName, 0755)
			os.Chdir(repoName)
			os.MkdirAll(repoName, 0755)
			// Initializing Empty git repo
			out, _ := exec.Command("git", "init").Output()
			fmt.Printf("[+] %v\n", string(out))
			// Adding Remote
			out, _ = exec.Command("git", "remote", "add", "origin", fmt.Sprintf("%v", dest["ssh_url"])).Output()
			fmt.Printf("[+] Success\n")
		}
	}
}

func main() {
	// Gets the repo-name
	repoName := flag.String("n", "", "Name of your desired REPO!")
	private := flag.Bool("p", false, "Is the repo private or not?")
	// Show Usage Info
	flag.Usage = func() {
		fmt.Printf("Usage: Github Auto repo Creator [OPTIONS] argument ...\n")
		flag.PrintDefaults()
	}
	// Parse Commands
	flag.Parse()
	// Creating Repo on github and a directory with that on local
	create(*repoName, *private)
}
