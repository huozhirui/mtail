#/bin/sh
#set -x
echo "start mtail">/dev/stdout


MAIIL_PRO_DIR=/progs           # servce log path
PORT=3903                       # port
POLL_LOG_INTERVAL=15s           # poll_log_interval


while [ "1" = "1" ]
do
    LOGPATH=
    # load service path
    for file in `ls ${MAIIL_PRO_DIR} | grep ".mtail"`
    do
        _LOGPATH=`grep log_filepath ${MAIIL_PRO_DIR}/${file} | grep log_filepath| sed s/[[:space:]]//g | awk -F = '{printf("%s,",$2)}'`
        LOGPATH="${LOGPATH}${_LOGPATH}"
    done
    LOGPATH="'${LOGPATH%?}'"

    # 判断matil进程是否存在
    ps -ef | grep -v grep | grep -q mtail
    if [ $? -eq 1 ] &&  [ ${LOGPATH} != "''" ]  ; then
        /mtail -logs=$LOGPATH -progs $MAIIL_PRO_DIR -port=$PORT -poll_log_interval=$POLL_LOG_INTERVAL -logtostderr &
        echo `date "+%Y-%m-%d %H:%M:%S"`' mtail start to run,path:${LOGPATH}'>/dev/stdout
    fi

    # check  log path
    if [[ ${LOGPATH} == "''" ]]; then
        echo `date "+%Y-%m-%d %H:%M:%S"` " no mtail config path:${LOGPATH}">/dev/stdout
    fi

    sleep 1m
done