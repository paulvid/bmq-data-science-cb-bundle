#!/bin/bash

###############################
# 0. Initializing environment #
###############################

export PATH=$PATH:/Users/pvidal/Documents/Playground/cb-cli/

###################################################
# 1. Dumping current data and adding it to recipe #
###################################################

rm -rf poci-bmq-data-science.sh >/dev/null 2>&1
echo "mysql -u bmq_user -pBe@stM0de beast_mode_db --execute=\"""$(mysqldump -u bm_user -pHWseftw33# beast_mode_db 2> /dev/null)""\"" >> poci-bmq-data-science.sh 


##################################
# 2. Adding recipe to cloudbreak #
##################################

TOKEN=$(curl -k -iX POST -H "accept: application/x-www-form-urlencoded" -d 'credentials={"username":"pvidal@hortonworks.com","password":"HWseftw33#"}' "https://192.168.56.100/identity/oauth/authorize?response_type=token&client_id=cloudbreak_shell&scope.0=openid&source=login&redirect_uri=http://cloudbreak.shell" | grep location | cut -d'=' -f 3 | cut -d'&' -f 1)
echo $TOKEN

ENCODED_RECIPE=$(base64 poci-bmq-data-science.sh)


curl -X DELETE \
  https://192.168.56.100/cb/api/v1/recipes/user/poci-bmq-data-science \
  -H "Authorization: Bearer $TOKEN" \
  -k

curl -X POST \
  https://192.168.56.100/cb/api/v1/recipes/user \
  -H "Authorization: Bearer $TOKEN" \
  -H 'Content-Type: application/json' \
  -H 'cache-control: no-cache' \
  -d " {
        \"name\": \"poci-bmq-data-science\",
        \"description\": \"Recipe loading BMQ data post BMQ cluster launch\",
        \"recipeType\": \"POST_CLUSTER_INSTALL\",
        \"content\": \"$POST_CLUSTER_INSTALL\"
    }" \
  -k

########################
# 3. Launching cluster #
########################

cb cluster create --cli-input-json tp-bmq-data-science.json --name bmq-data-science-$(date +%s)

