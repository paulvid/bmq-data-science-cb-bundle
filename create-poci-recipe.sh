rm -rf poci-bmq-data-science.sh >/dev/null 2>&1
echo "mysql -u bmq_user -pBe@stM0de beast_mode_db --execute=\"""$(mysqldump -u bm_user -pHWseftw33# beast_mode_db | sed s/\`//g 2> /dev/null )""\"" >> poci-bmq-data-science.sh 
chmod a+x poci-bmq-data-science.sh 