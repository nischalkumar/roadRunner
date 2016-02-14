#!/bin/bash
function get_auth {
#echo "inside get_auth with param $1"
server_addr=$1
output=$(curl -X POST -ku clientapp:123456 "$server_addr/oauth/token" -H "Accept: application/json" -d "password=check&username=ADMIN&grant_type=password&scope=read%20write&client_secret=123456&client_id=clientapp")
token=$(echo $output | awk -F',' '{print $1}' | awk -F':' '{print $2}' | sed 's/"//g')
echo "$token"

}
function GET_CURL {
oAuth_token=$1
endpoint="$2$3"
curl -kX GET -v  -H "Accept: application/json" -H "Authorization: Bearer $oAuth_token" -H "Content-Type: application/json" "$endpoint"
}
function POST_CURL {
oAuth_token=$1
endpoint="$2$3"
data="-d'$4'"
echo "================="
echo "data: $data"
echo "================="
echo "================="

}



echo "inputs $1 $2 $3 $4"
oAuth_token=$(get_auth $2)
METHOD=$1
echo "-------------"

echo "auth_token $oAuth_token"
if [[ $METHOD == *"GET"* ]]
then
	echo "---GET---"
	GET_CURL $oAuth_token $2 $3
elif [[ $METHOD == *"POST"* ]]
then
	echo "---POST---"
	echo "data $4"
	echo "----------------------------"
	curl -kX POST --data "$4"  -v  -H "Accept: application/json" -H "Authorization: Bearer $oAuth_token" -H "Content-Type: application/json" "$2$3"
	#POST_CURL $aAuth_token $2 $3 $4
else
	echo "---ELSE---"
	GET_CURL $oAuth_token $2 $3
fi
	

