/*
   Copyright 2022 Baidu Inc. All Rights Reserved.
   @Authors: huozhirui(huozhirui@baidu.com)
   Date:     2022/11/24 17:38

*/

package tailer

import (
	"fmt"
	"strings"
	"time"
)

func myParseLogPath(pattern string) []string {

	if strings.HasSuffix(pattern, ".yyyymmddhh") {

		curTime := fmt.Sprintf(time.Now().Format("2006010215"))
		return []string{strings.Replace(pattern, "yyyymmddhh", curTime, -1)}

	} else if strings.HasSuffix(pattern, ".yyyymmdd") {

		curTime := fmt.Sprintf(time.Now().Format("20060102"))
		return []string{strings.Replace(pattern, "yyyymmdd", curTime, -1)}

	} else if strings.HasSuffix(pattern, ".yymmdd") {

		curTime := fmt.Sprintf(time.Now().Format("060102"))
		return []string{strings.Replace(pattern, "yymmdd", curTime, -1)}
	}
	return nil
}
