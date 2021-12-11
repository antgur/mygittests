#!/bin/bash
 
tail -f /var/log/messages &
T1=${!}
echo "PID=${T1}"
nf=$((`ls -l /var/log | wc -l`))
nnf=$nf
 
while true
do
  ct=$(date +%H:%M)
#  echo "ct=${ct}"
  if [[ "$ct" > "23:00" ]]; then
    break
  fi
  nnf=$nf
  nf=$((`ls -l /var/log | wc -l`))
#  echo "nf=${nf}"
  if [ $nf -gt $nnf ]; then
    kill -TERM ${T1}
    sleep 2
    tail -f /var/log/messages &
    T1=${!}
#    echo "PID=${T1}"
  fi
  sleep 3
done
kill -TERM ${T1}
echo "STOP"
