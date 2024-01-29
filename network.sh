#/bin/bash

send_email(){
      echo "Network health failures detected."|mail -s "!!! Network failure !!!" venkatasai@gmil.com
      
}

#send_email
taergets=("www.w3schools.com" "www.youtube.com" "www.github.com")

for i in ${targets[@]}; do
        ping -c 5 "$i"
        echo -e $(date)\n >> network.log
        if [ $? -eq 0]; then
                echo -e "ping to $i is sucessful!\n">>network.log
        else
                echo "ping to $i failed" >>network.log
                send_email
        fi
done
echo "****"