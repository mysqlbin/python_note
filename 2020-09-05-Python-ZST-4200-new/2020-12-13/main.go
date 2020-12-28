package main

import (
	"encoding/json"
	"github.com/XiaoMi/soar/common"
	"io/ioutil"
	"net/http"
)

type SQLAdviseRequest struct {
	Schema string `json:"schema"`
	SQL string `json:"sql"`
}

func advisorHandler(w http.ResponseWriter, req *http.Request) {
	// input: sql 哪里来，从request中去取
	// process: soar code 逻辑，解析这个sql，给出优化建议
	// output: 优化建议，写到哪里？ w.Write([]byte("xxx"))

	// 1. 从request取出 sql语句
	// 我们这个是get请求还是post好、
	// 因为有些sql很长，发送get请求，附带的参数长度是有限制
	// get请求会被记录在nginx的日志里面，sql语句里面有些敏感数据
	adviseRequest := SQLAdviseRequest{}

	s, err := ioutil.ReadAll(req.Body)
	// python None; go nil
	if err != nil {
		w.WriteHeader(500)
		common.Log.Error("failed to read body: %s", err)
		return
	}
	// python adviserRequest = json.loads(s)
	if err =json.Unmarshal(s, &adviseRequest); err != nil {
		w.WriteHeader(500)
		common.Log.Error("failed to parse body: %s", err)
		return
	}

	common.Log.Info("request: %v", adviseRequest)
	w.WriteHeader(200)
	w.Write([]byte("hello world"))
}

func main() {
	common.Log.Info("test")
	http.HandleFunc("/api/adviser", advisorHandler)

	http.ListenAndServe(":8090", nil)
}
