package main

import (
	"encoding/json"
	"fmt"
	"io/ioutil"
	"net/http"
	"strings"
	"github.com/percona/go-mysql/query"
)

type SQLAdviseRequest struct {
	SQL string `json:"sql"`
}

type SQLAdviseResponse struct {
	Fingerprint string `json:"finger_print"`
}


func handler(w http.ResponseWriter, req *http.Request) {

	adviseRequest := SQLAdviseRequest{}

	s, err := ioutil.ReadAll(req.Body)
	// python None; go nil
	if err != nil {
		w.WriteHeader(500)
		return
	}

	// python adviserRequest = json.loads(s)
	if err =json.Unmarshal(s, &adviseRequest); err != nil {
		w.WriteHeader(500)
		return
	}

	fingerprint := strings.TrimSpace(query.Fingerprint(adviseRequest.SQL))
	w.WriteHeader(200)

	response := SQLAdviseResponse{
		Fingerprint: fingerprint,
	}

	respBytes, err := json.Marshal(response)

	if err != nil {
		w.WriteHeader(500)
		return
	}

	w.Write(respBytes)
}

func main() {
	http.HandleFunc("/api", handler)
	err := http.ListenAndServe(":8090", nil)
	if err != nil {
		fmt.Errorf("err: %s", err)
	}
}


/*
func handler(w http.ResponseWriter, r *http.Request) {
	w.WriteHeader(200)
	w.Write([]byte("hello world"))
}

func main() {
	http.HandleFunc("/api", handler)
	err := http.ListenAndServe(":8090", nil)
	if err != nil {
		fmt.Errorf("err: %s", err)
	}
}
*/

