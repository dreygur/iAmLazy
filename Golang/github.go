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
	"strings"

	"github.com/imroc/req"
)

func create(repoName string, private bool) {
	username := "dreygur"                               // Github Username
	token := "1a1606d93e1b05099e893145e2199cfa098baa38" // Github Personal Auth-Token

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
	if private == true {
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
	private := flag.Bool("p", false, "")

	// Show Usage Info
	flag.Usage = func() {
		h := "Usage: Github Auto repo Creator [OPTIONS] argument ...\n\n"

		h += "Usage:\n"
		h += "  github [NAME] [OPTIONS]\n\n"

		h += "Options:\n"
		h += "  -p, --ungron     Is the repo private or not?\n"
		h += "      --version    Print version information\n\n"

		h += "Examples:\n"
		h += "  github Test\n"
		h += "  github Test -p\n"

		fmt.Fprintf(os.Stderr, h)
	}
	// Parse Commands
	flag.Parse()

	// RepoName
	repoName := flag.Arg(0)
	if repoName == "" {
		fmt.Println("[*] Please Provide a REPO name")
	} else if strings.HasPrefix(repoName, "-") {
		flag.Usage()
	} else {
		// Creating Repo on github and a directory with that on local
		create(repoName, *private)
	}
}
