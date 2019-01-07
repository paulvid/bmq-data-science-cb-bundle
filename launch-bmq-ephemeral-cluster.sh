#!/bin/bash

###############################
# 0. Initializing environment #
###############################

export PATH=$PATH:/Users/pvidal/Documents/Playground/cb-cli/

###################################################
# 1. Dumping current data and adding it to recipe #
###################################################

rm -rf poci-bmq-data-science.sh >/dev/null 2>&1
echo "mysql -u bmq_user -pBe@stM0de beast_mode_db --execute=\"""$(mysqldump -u bm_user -pHWseftw33# beast_mode_db | sed s/\`//g 2> /dev/null )""\"" >> poci-bmq-data-science.sh 

echo "token=\$(curl -i --data 'userName=admin&password=Be@stM0de' -X POST http://localhost:9995/api/login | grep JSESSIONID | tail -1 | sed s/Set-Cookie\:\ //g | awk -F\";\" '{print \$1}' | awk -F\"=\" '{print \$2}')" >> poci-bmq-data-science.sh 


echo "curl -X PUT http://localhost:9995/api/interpreter/setting/jdbc \
 -H 'Content-Type: application/json'  \
 -b \"JSESSIONID=\"\$token\"; Path=/; HttpOnly\"  \
 -d '{
  \"properties\": {
            \"default.url\": {
                \"name\": \"default.url\",
                \"value\": \"jdbc:postgresql://localhost:5432/\",
                \"type\": \"string\"
            },
            \"hive.proxy.user.property\": {
                \"name\": \"hive.proxy.user.property\",
                \"value\": \"hive.server2.proxy.user\",
                \"type\": \"string\"
            },
            \"default.driver\": {
                \"name\": \"default.driver\",
                \"value\": \"org.postgresql.Driver\",
                \"type\": \"string\"
            },
            \"zeppelin.jdbc.principal\": {
                \"name\": \"zeppelin.jdbc.principal\",
                \"value\": \"\",
                \"type\": \"string\"
            },
            \"hive.driver\": {
                \"name\": \"hive.driver\",
                \"value\": \"org.apache.hive.jdbc.HiveDriver\",
                \"type\": \"string\"
            },
            \"default.completer.ttlInSeconds\": {
                \"name\": \"default.completer.ttlInSeconds\",
                \"value\": \"120\",
                \"type\": \"number\"
            },
            \"hive.password\": {
                \"name\": \"hive.password\",
                \"value\": \"\",
                \"type\": \"string\"
            },
            \"hive.user\": {
                \"name\": \"hive.user\",
                \"value\": \"hive\",
                \"type\": \"string\"
            },
            \"default.password\": {
                \"name\": \"default.password\",
                \"value\": \"\",
                \"type\": \"string\"
            },
            \"hive.splitQueries\": {
                \"name\": \"hive.splitQueries\",
                \"value\": \"true\",
                \"type\": \"string\"
            },
            \"default.completer.schemaFilters\": {
                \"name\": \"default.completer.schemaFilters\",
                \"value\": \"\",
                \"type\": \"textarea\"
            },
            \"default.splitQueries\": {
                \"name\": \"default.splitQueries\",
                \"value\": false,
                \"type\": \"checkbox\"
            },
            \"default.user\": {
                \"name\": \"default.user\",
                \"value\": \"gpadmin\",
                \"type\": \"string\"
            },
            \"zeppelin.jdbc.concurrent.max_connection\": {
                \"name\": \"zeppelin.jdbc.concurrent.max_connection\",
                \"value\": \"10\",
                \"type\": \"string\"
            },
            \"common.max_count\": {
                \"name\": \"common.max_count\",
                \"value\": \"1000\",
                \"type\": \"string\"
            },
            \"default.precode\": {
                \"name\": \"default.precode\",
                \"value\": \"\",
                \"type\": \"textarea\"
            },
            \"zeppelin.jdbc.auth.type\": {
                \"name\": \"zeppelin.jdbc.auth.type\",
                \"value\": \"\",
                \"type\": \"string\"
            },
            \"default.statementPrecode\": {
                \"name\": \"default.statementPrecode\",
                \"value\": \"\",
                \"type\": \"string\"
            },
            \"zeppelin.jdbc.concurrent.use\": {
                \"name\": \"zeppelin.jdbc.concurrent.use\",
                \"value\": \"true\",
                \"type\": \"string\"
            },
            \"zeppelin.jdbc.keytab.location\": {
                \"name\": \"zeppelin.jdbc.keytab.location\",
                \"value\": \"\",
                \"type\": \"string\"
            },
            \"hive.url\": {
                \"name\": \"hive.url\",
                \"value\": \"jdbc:hive2://ip-172-31-22-223.ec2.internal:2181/;serviceDiscoveryMode=zooKeeper;zooKeeperNamespace=hiveserver2\",
                \"type\": \"string\"
            },
            \"zeppelin.jdbc.interpolation\": {
                \"name\": \"zeppelin.jdbc.interpolation\",
                \"value\": false,
                \"type\": \"checkbox\"
            },
            \"mysql.driver\": {
            	\"name\": \"mysql.driver\",
                \"value\": \"com.mysql.jdbc.Driver\",
                \"type\": \"string\"
            },
            \"mysql.user\": {
            	\"name\": \"mysql.user\",
                \"value\": \"bmq_user\",
                \"type\": \"string\"
            },
            \"mysql.password\": {
            	\"name\": \"mysql.password\",
                \"value\": \"Be@stM0de\",
                \"type\": \"password\"
            },
            \"mysql.url\": {
            	\"name\": \"mysql.url\",
                \"value\": \"jdbc:mysql://localhost:3306/beast_mode_db\",
                \"type\": \"string\"
            }
        },
  \"dependencies\":[{\"groupArtifactVersion\": \"mysql:mysql-connector-java:5.1.38\"}],
  
        \"option\": {
            \"remote\": true,
            \"port\": -1,
            \"perNote\": \"shared\",
            \"perUser\": \"shared\",
            \"isExistingProcess\": false,
            \"setPermission\": false,
            \"owners\": [],
            \"isUserImpersonate\": false
        }
}' " >> poci-bmq-data-science.sh

echo "curl -X PUT http://localhost:9995/api/interpreter/setting/restart/jdbc  -H 'Content-Type: application/json'   -b \"JSESSIONID=\"\$token\"; Path=/; HttpOnly\"" >> poci-bmq-data-science.sh

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
        \"content\": \"$ENCODED_RECIPE\"
    }" \
  -k

########################
# 3. Launching cluster #
########################

cb cluster create --cli-input-json tp-bmq-data-science.json --name bmq-data-science-$(date +%s)

