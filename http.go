// http
package main

import "C"
import (
	"fmt"
	"io/ioutil"
	"net/http"
)

//export http_get
func http_get(c_url *C.char) *C.char {
	url := C.GoString(c_url)
	client := &http.Client{}
	req, _ := http.NewRequest("GET", url, nil)
	resp, _ := client.Do(req) //发送
	defer resp.Body.Close()
	data, _ := ioutil.ReadAll(resp.Body)
	fmt.Println(data)
	return C.CString(string(data))
}

func main() {
}
