/*
   Copyright 2022 Baidu Inc. All Rights Reserved.
   @Authors: huozhirui(huozhirui@baidu.com)
   Date:     2022/11/24 17:38

*/

package tailer

import (
	"fmt"
	"github.com/golang/glog"
	"os"
	"strings"
	"time"
)

func myParseLogPath(pattern string) []string {
	zone := "Asia/Shanghai"
	envZone := os.Getenv("TZ")
	if envZone != "" {
		zone = envZone
	}

	cstZone, err := time.LoadLocation(zone)
	if err != nil {
		glog.V(2).Infof("%s.", err)
		zone = "Asia/Shanghai"
		cstZone, _ = time.LoadLocation(zone)
	}
	if strings.HasSuffix(pattern, ".yyyymmddhh") {

		curTime := fmt.Sprintf(time.Now().In(cstZone).Format("2006010215"))
		return []string{strings.Replace(pattern, "yyyymmddhh", curTime, -1)}

	} else if strings.HasSuffix(pattern, ".yyyymmdd") {

		curTime := fmt.Sprintf(time.Now().In(cstZone).Format("20060102"))
		return []string{strings.Replace(pattern, "yyyymmdd", curTime, -1)}

	} else if strings.HasSuffix(pattern, ".yymmdd") {

		curTime := fmt.Sprintf(time.Now().In(cstZone).Format("060102"))
		return []string{strings.Replace(pattern, "yymmdd", curTime, -1)}
	}
	return nil
}
