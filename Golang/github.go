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
	"runtime"

	"github.com/imroc/req"
)

// Body Structure as json
type Body struct {
	Name    string `json:"name"`
	Private *bool  `json:"private,omitempty"`
}

var reset string = "\033[0m"
var red string = "\033[31m"
var green string = "\033[32m"
var yellow string = "\033[33m"
var blue string = "\033[34m"
var purple string = "\033[35m"
var cyan string = "\033[36m"
var gray string = "\033[37m"
var white string = "\033[97m"

func init() {
	if runtime.GOOS == "windows" {
		reset = ""
		red = ""
		green = ""
		yellow = ""
		blue = ""
		purple = ""
		cyan = ""
		gray = ""
		white = ""
	}
}

func create(repoName string, private bool) {
	username := ""                               // Github Username
	token := "" // Github Personal Auth-Token

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
	prv := new(bool)
	*prv = false
	if private == true {
		*prv = true
	}

	// Basic commands to Create the repo as body JSON
	body, _ := json.Marshal(Body{repoName, prv})

	// Getting just the JSON response
	req.SetFlags(req.LrespBody)
	res, err := req.Post(createRepo, header, body)
	if err != nil {
		log.Fatal(err)
	}
	var dest map[string]interface{}
	res.ToJSON(&dest)

	if dest["ssh_url"] != nil {
		fmt.Printf("%v[+] SSH URL: %+v%v\n", blue, dest["ssh_url"], reset)
		_, err = os.Stat(repoName)
		if err != nil {
			// Creating Directory with Write-Execution Mode and changing path to that
			os.MkdirAll(repoName, 0755)
			os.Chdir(repoName)
			// Initializing Empty git repo
			out, _ := exec.Command("git", "init").Output()
			fmt.Printf("%v[+] %v%v", green, string(out), reset)
			// Adding Remote
			out, _ = exec.Command("git", "remote", "add", "origin", fmt.Sprintf("%v", dest["ssh_url"])).Output()
			fmt.Printf(green + "[+] Success!\n" + reset)
		} else {
			fmt.Println(red + "[-] Directory Already Exists!" + reset)
		}
	}
}

func main() {
	private := flag.Bool("p", false, "")
	// Parse Commands
	flag.Parse()
	// Show Usage Info
	flag.Usage = func() {
		h := "Usage: Github Auto repo Creator [OPTIONS] argument ...\n\n"

		h += "Usage:\n"
		h += "  github [NAME] [OPTIONS]\n\n"

		h += "Options:\n"
		h += "  -p, --privare     Is the repo private or not?\n"

		h += "Examples:\n"
		h += "  github Test\n"
		h += "  github -p Test\n"

		fmt.Fprintf(os.Stderr, h)
	}

	// RepoName
	if len(os.Args) > 2 {
		raw := os.Args[2]
		// Creating Repo on github and a directory with that on local
		create(raw, *private)
	} else if len(os.Args) == 2 {
		raw := os.Args[1]
		create(raw, *private)
	} else {
		flag.Usage()
	}

}
