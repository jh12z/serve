package main

import (
	"log"
	"net/http"
	"os"
	"strings"
)

func main() {
	var s string
	if len(os.Args) == 1 {
		s = "."
	} else {
		s = os.Args[1]
	}

	fs := http.FileServer(http.Dir(s))
	handler := http.HandlerFunc(func(w http.ResponseWriter, r *http.Request) {
		hostname := strings.Split(r.Host, ":")[0]
		r.URL.Path = "/" + hostname + r.URL.Path
		log.Println(r.Method + " " + r.URL.Path)
		fs.ServeHTTP(w, r)
	})

	log.Println("Serving virtual hosts from " + s + " on :8080 ...")
	err := http.ListenAndServe(":8080", handler)
	if err != nil {
		log.Fatal(err)
	}
}
