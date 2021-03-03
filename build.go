// Grafts in the stream json into the configmap stub.
package main

import (
	"encoding/json"
	"fmt"
	"io/ioutil"
	"os"
)


func run(src, dest string) error {
	var cm map[string]interface{}
	b, err := ioutil.ReadFile(src)
	if err != nil {
		return err
	}
	err = json.Unmarshal(b, &cm)
	if err != nil {
		return err
	}

	bootimages, err := ioutil.ReadFile("rhcos-4.8.json")
	if err != nil {
		return err
	}
	data := cm["data"].(map[string]interface{})
	data["stream"] = string(bootimages)

	b, err = json.Marshal(cm)
	if err != nil {
		return err
	}

	err = ioutil.WriteFile(dest, b, 0644)
	if err != nil {
		return err
	}

	return nil
}

func main() {
	if err := run(os.Args[1], os.Args[2]); err != nil {
		fmt.Fprintf(os.Stderr, "%s\n", err)
		os.Exit(1)
	}
}
