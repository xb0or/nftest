#!/bin/bash
function test_ipv4() {
    result=`curl --connect-timeout 10 -4sSL "https://www.netflix.com/" 2>&1`;
    if [ "$result" == "Not Available" ];then
        echo -e "\033[34m很遗憾 Netflix不服务此地区\033[0m";
        return;
    fi
    
    if [[ "$result" == "curl"* ]];then
        echo -e "\033[31m错误 无法连接到Netflix官网\033[0m";
        return;
    fi
    
    result=`curl -4sL "https://www.netflix.com/title/80018499" 2>&1`;
    if [[ "$result" == *"page-404"* ]] || [[ "$result" == *"NSEZ-403"* ]];then
        echo -e "\033[31m很遗憾 你的IP不能看Netflix\033[0m";
        return;
    fi
    
    result1=`curl -4sL "https://www.netflix.com/title/70143836" 2>&1`;

    
    if [[ "$result1" == *"page-404"* ]];then
        echo -e "\033[33m你的IP可以打开Netflix 但是仅解锁自制剧\033[0m";
        return;
    fi
    #奈飞IPV4区域测试
    region=`tr [:lower:] [:upper:] <<< $(curl -4is "https://www.netflix.com/title/80018499" 2>&1 | sed -n '8p' | awk '{print $2}' | cut -d '/' -f4 | cut -d '-' -f1)` ;

    if [[ "$region" == *"INDEX"* ]];then
       region="US";
    fi

    echo -e "\033[32m恭喜 你的IP可以打开Netflix 并解锁全部流媒体 区域: ${region}\033[0m";
    return;
}

function test_ipv6() {
    result=`curl --connect-timeout 10 -6sSL "https://www.netflix.com/" 2>&1`;
    if [ "$result" == "Not Available" ];then
        echo -e "\033[34m很遗憾 Netflix不服务此地区\033[0m";
        return;
    fi
    
    if [[ "$result" == "curl"* ]];then
        echo -e "\033[31m错误 无法连接到Netflix官网\033[0m";
        return;
    fi
    
    result=`curl -6sL "https://www.netflix.com/title/80018499" 2>&1`;
    if [[ "$result" == *"page-404"* ]] || [[ "$result" == *"NSEZ-403"* ]];then
        echo -e "\033[31m很遗憾 你的IP不能看Netflix\033[0m";
        return;
    fi
    
    result1=`curl -6sL "https://www.netflix.com/title/70143836" 2>&1`;
    
    
    if [[ "$result1" == *"page-404"* ]];then
        echo -e "\033[33m你的IP可以打开Netflix 但是仅解锁自制剧\033[0m";
        return;
    fi
    #奈飞IPV4区域测试
    region=`tr [:lower:] [:upper:] <<< $(curl -6is "https://www.netflix.com/title/80018499" 2>&1 | sed -n '8p' | awk '{print $2}' | cut -d '/' -f4 | cut -d '-' -f1)` ;  
    if [[ "$region" == *"INDEX"* ]];then
       region="US";
    fi
    
    echo -e "\033[32m恭喜 你的IP可以打开Netflix 并解锁全部流媒体 区域: ${region}\033[0m";
    return;
}
#export LANG="en_US";
#export LANGUAGE="en_US";
#export LC_ALL="en_US";


curl -V > /dev/null 2>&1;
if [ $? -ne 0 ];then
    echo -e "\033[31mPlease install curl\033[0m";
    exit;
fi


yt_ipv4(){
   #油管IPV4区域测试
   area=$(curl -4 -s https://www.youtube.com/red | sed 's/,/\n/g' | grep countryCode | cut -d '"' -f4)
if [ ! -n "$area" ]; then
    area=不显示
fi
echo -e "\033[32m你的油管角标: ${area}\033[0m";
}
yt_ipv6(){
   #油管IPV6区域测试
   area=$(curl -6 -s https://www.youtube.com/red | sed 's/,/\n/g' | grep countryCode | cut -d '"' -f4)
if [ ! -n "$area" ]; then
    area=不显示
fi
echo -e "\033[32m你的油管角标: ${area}\033[0m";
}



#目录

echo -e "\033[36m 测试脚本 V2.0 \033[0m"
echo -e "\033[36m GitHub：https://github.com/xb0or/nftest \033[0m"
echo -e "\033[36m bash <(curl -sSL "https://raw.githubusercontent.com/xb0or/nftest/main/netflix.sh") \033[0m"

echo " ** 正在测试 IPv4 解锁情况";
check4=`ping 1.1.1.1 -c 1 2>&1`;
if [[ "$check4" != *"received"* ]] && [[ "$check4" != *"transmitted"* ]];then
    echo -e "\033[34m当前主机不支持IPv4,跳过...\033[0m";
else
test_ipv4
yt_ipv4
fi

echo " ** 正在测试 IPv6 解锁情况";
check6=`ping6 240c::6666 -c 1 2>&1`;
if [[ "$check6" != *"received"* ]] && [[ "$check6" != *"transmitted"* ]];then
echo -e "\033[34m当前主机不支持IPv6,跳过...\033[0m";    

else
    test_ipv6
    yt_ipv6
fi
