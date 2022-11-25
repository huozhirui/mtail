/*
   Copyright 2022 Baidu Inc. All Rights Reserved.
   @Authors: huozhirui(huozhirui@baidu.com)
   Date:     2022/11/24 17:57

*/

package tailer

import (
	"fmt"
	"testing"
)

func TestRelativeLog(t *testing.T) {

	logPath := "/log/isis/isis.yyyymmddhh"
	absLogPath := myParseLogPath(logPath)
	fmt.Println(absLogPath)

	logPath = "/log/isis/isis.yyyymmddhh"
	absLogPath = myParseLogPath(logPath)
	fmt.Println(absLogPath)

	logPath = "/log/isis/isis.yyyymmdd"
	absLogPath = myParseLogPath(logPath)
	fmt.Println(absLogPath)

	logPath = "/log/isis/isis"
	absLogPath = myParseLogPath(logPath)
	fmt.Println(absLogPath)

	logPath = "/log/isis/isis*"
	absLogPath = myParseLogPath(logPath)
	fmt.Println(absLogPath)
}
