package main

import (
	"fmt"
	"github.com/assemblyline/assemblyline/app"
	"github.com/davecgh/go-spew/spew"
	"github.com/ghodss/yaml"
	"io/ioutil"
)

func check(e error) {
	if e != nil {
		panic(e)
	}
}

func main() {
	dat, err := ioutil.ReadFile("Assemblyfile")
	check(err)
	var app app.App
	err = yaml.Unmarshal(dat, &app)
	if err != nil {
		fmt.Printf("err: %v\n", err)
		return
	}
	spew.Dump(app)
}
