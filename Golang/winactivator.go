package main

import (
	"log"
	"os/exec"
	"regexp"
)

func errHandler(err error) {
	if err != nil {
		log.Fatal(err)
	}
}

func main() {
	// Not Completed Yet!
	/**
	 * Commands
	 * slmgr /skms kms.03k.org
	 * slmgr /ato
	 * Generic Keys: https://docs.microsoft.com/en-us/windows-server/get-started/kms-client-activation-keys
	 */
	// stdout, err = exec.Command(`cscript`, `//nologo`, `c:\windows\system32\slmgr.vbs`, `/skms`, `kms.03k.org`).Output()
	stdout, err := exec.Command(`cscript`, `//nologo`, `c:\windows\system32\slmgr.vbs`, `/ato`).Output()
	errHandler(err)

	match, err := regexp.MatchString(`successfully`, string(stdout))
	errHandler(err)

	if match {
		log.Println("Successfully installed!")
		// err := exec.Command(`shutdown.exe`, `/r`, `/t`, `00`).Run()
		// errHandler(err)
	} else {
		println("Failed to install")
	}
}
