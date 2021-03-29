#!/bin/bash
Font_Black="\033[30m";
Font_Red="\033[31m";
Font_Green="\033[32m";
Font_Yellow="\033[33m";
Font_Blue="\033[34m";
Font_Purple="\033[35m";
Font_SkyBlue="\033[36m";
Font_White="\033[37m";
Font_Suffix="\033[0m";

function test_ipv4() {
echo -e "Netflix：";
    result=`curl --connect-timeout 10 -4sSL "https://www.netflix.com/" 2>&1`;
    if [ "$result" == "Not Available" ];then
        echo -e "${Font_Red}很遗憾 Netflix不服务此地区${Font_Suffix}";
        return;
    fi
    
    if [[ "$result" == "curl"* ]];then
        echo -e "${Font_Red}错误 无法连接到Netflix官网${Font_Suffix}";
        return;
    fi
    
    result=`curl -4sL "https://www.netflix.com/title/80018499" 2>&1`;
    if [[ "$result" == *"page-404"* ]] || [[ "$result" == *"NSEZ-403"* ]];then
        echo -e "${Font_Red}很遗憾 你的IP不能看Netflix${Font_Suffix}";
        return;
    fi
    
    result1=`curl -4sL "https://www.netflix.com/title/70143836" 2>&1`;
    result2=`curl -4sL "https://www.netflix.com/title/80027042" 2>&1`;
    result3=`curl -4sL "https://www.netflix.com/title/70140425" 2>&1`;
    result4=`curl -4sL "https://www.netflix.com/title/70283261" 2>&1`;
    result5=`curl -4sL "https://www.netflix.com/title/70143860" 2>&1`;
    result6=`curl -4sL "https://www.netflix.com/title/70202589" 2>&1`;
    
    if [[ "$result1" == *"page-404"* ]] && [[ "$result2" == *"page-404"* ]] && [[ "$result3" == *"page-404"* ]] && [[ "$result4" == *"page-404"* ]] && [[ "$result5" == *"page-404"* ]] && [[ "$result6" == *"page-404"* ]];then
        echo -e "${Font_Yellow}你的IP可以打开Netflix 但是仅解锁自制剧${Font_Suffix}";
        return;
    fi
    #奈飞IPV4区域测试
    region=`tr [:lower:] [:upper:] <<< $(curl -4is "https://www.netflix.com/title/80018499" 2>&1 | sed -n '8p' | awk '{print $2}' | cut -d '/' -f4 | cut -d '-' -f1)` ;

    if [[ "$region" == *"INDEX"* ]];then
       region="US";
    fi

    echo -e "${Font_Green}恭喜 你的IP可以打开Netflix 并解锁全部流媒体 区域: ${region}${Font_Suffix}";
    return;
}

function test_ipv6() {
echo -e "Netflix：";
    result=`curl --connect-timeout 10 -6sSL "https://www.netflix.com/" 2>&1`;
    if [ "$result" == "Not Available" ];then
        echo -e "${Font_Red}很遗憾 Netflix不服务此地区${Font_Suffix}";
        return;
    fi
    
    if [[ "$result" == "curl"* ]];then
        echo -e "${Font_Red}错误 无法连接到Netflix官网${Font_Suffix}";
        return;
    fi
    
    result=`curl -6sL "https://www.netflix.com/title/80018499" 2>&1`;
    if [[ "$result" == *"page-404"* ]] || [[ "$result" == *"NSEZ-403"* ]];then
        echo -e "${Font_Red}很遗憾 你的IP不能看Netflix${Font_Suffix}";
        return;
    fi
    
    result1=`curl -6sL "https://www.netflix.com/title/70143836" 2>&1`;
    result2=`curl -6sL "https://www.netflix.com/title/80027042" 2>&1`;
    result3=`curl -6sL "https://www.netflix.com/title/70140425" 2>&1`;
    result4=`curl -6sL "https://www.netflix.com/title/70283261" 2>&1`;
    result5=`curl -6sL "https://www.netflix.com/title/70143860" 2>&1`;
    result6=`curl -6sL "https://www.netflix.com/title/70202589" 2>&1`;
    
    if [[ "$result1" == *"page-404"* ]] && [[ "$result2" == *"page-404"* ]] && [[ "$result3" == *"page-404"* ]] && [[ "$result4" == *"page-404"* ]] && [[ "$result5" == *"page-404"* ]] && [[ "$result6" == *"page-404"* ]];then
        echo -e "${Font_Yellow}你的IP可以打开Netflix 但是仅解锁自制剧${Font_Suffix}";
        return;
    fi
    #奈飞IPV4区域测试
    region=`tr [:lower:] [:upper:] <<< $(curl -6is "https://www.netflix.com/title/80018499" 2>&1 | sed -n '8p' | awk '{print $2}' | cut -d '/' -f4 | cut -d '-' -f1)` ;  
    if [[ "$region" == *"INDEX"* ]];then
       region="US";
    fi
    
    echo -e "${Font_Green}恭喜 你的IP可以打开Netflix 并解锁全部流媒体 区域: ${region}${Font_Suffix}";
    return;
}

yt_ipv4(){
echo -e "YouTube：";
   #油管IPV4区域测试
   area=$(curl --connect-timeout 10 -4s https://www.youtube.com/red | sed 's/,/\n/g' | grep countryCode | cut -d '"' -f4)
if [ ! -n "$area" ]; then
    echo -e "${Font_Yellow}你的油管角标不显示 可能不支持Premium${Font_Suffix}";
else
echo -e "${Font_Green}你的油管角标: ${area}${Font_Suffix}";
fi
}
yt_ipv6(){
echo -e "YouTube：";
   #油管IPV6区域测试
   area=$(curl --connect-timeout 10 -6s https://www.youtube.com/red | sed 's/,/\n/g' | grep countryCode | cut -d '"' -f4)
if [ ! -n "$area" ]; then
echo -e "${Font_Yellow}你的油管角标不显示 可能不支持Premium${Font_Suffix}";    
else
echo -e "${Font_Green}你的油管角标: ${area}${Font_Suffix}";
fi
}

steam_v4(){
echo -e "Steam：";
   area=$(curl --connect-timeout 10 -s https://store.steampowered.com/app/761830 | grep priceCurrency | cut -d '"' -f4)
   if [ ! -n "$area" ]; then
    echo -e "${Font_Red}错误！无法获取到货币数据${Font_Suffix}";
else
   echo -e "${Font_Green}你的 STEAM 货币为（仅限IPV4）: ${area}${Font_Suffix}";
fi
}
DisneyPlus_v4() {
echo -e "DisneyPlus：";
    local result=`curl --connect-timeout 10 -4sSL "https://www.disneyplus.com/movies/drain-the-titanic/5VNZom2KYtlb" 2>&1`;    
    if [[ "$result" == "curl"* ]];then
        echo -n -e "${Font_Red}错误，无法连接到迪士尼+${Font_Suffix}\n";
        return;
    fi
    
    if [[ "$result" == *"https://preview.disneyplus.com/unavailable/"* ]];then
        echo -n -e "${Font_Red}抱歉，您所在的地区无法使用迪士尼+${Font_Suffix}\n";
        return;
    fi
    
    if [[ "$result" == *"releaseYear"* ]];then
        echo -n -e "${Font_Green}恭喜，你的IP支持迪士尼+${Font_Suffix}\n";
        return;
    fi
echo -n -e "\r ${Font_Red}很遗憾，你的IP不支持迪士尼+${Font_Suffix}\n";
    return;
}

DisneyPlus_v6() {
echo -e "DisneyPlus：";
    local result=`curl --connect-timeout 10 -6sSL "https://www.disneyplus.com/movies/drain-the-titanic/5VNZom2KYtlb" 2>&1`;
    
    if [[ "$result" == "curl"* ]];then
        echo -n -e "${Font_Red}错误，无法连接到迪士尼+${Font_Suffix}\n";
        return;
    fi
    
    if [[ "$result" == *"https://preview.disneyplus.com/unavailable/"* ]];then
        echo -n -e "${Font_Red}抱歉，您所在的地区无法使用迪士尼+${Font_Suffix}\n";
        return;
    fi
    
    if [[ "$result" == *"releaseYear"* ]];then
        echo -n -e "${Font_Green}恭喜，你的IP支持迪士尼+${Font_Suffix}\n";
        return;
    fi
echo -n -e "\r ${Font_Red}很遗憾，你的IP不支持迪士尼+${Font_Suffix}\n"; 
    return;
}

#目录

echo -e "\033[36m 测试脚本 V2.8 \033[0m"
echo -e "\033[36m GitHub：https://github.com/xb0or/nftest \033[0m"
echo -e "\033[36m bash <(curl -sSL "https://raw.githubusercontent.com/xb0or/nftest/main/netflix.sh") \033[0m"

echo " ** 正在测试 IPv4 解锁情况";
check4=`ping 1.1.1.1 -c 1 2>&1`;
if [[ "$check4" != *"received"* ]] && [[ "$check4" != *"transmitted"* ]];then
    echo -e "\033[34m当前主机不支持IPv4,跳过...\033[0m";
else
test_ipv4
yt_ipv4
steam_v4
DisneyPlus_v4
fi

echo " ** 正在测试 IPv6 解锁情况";
check6=`ping6 240c::6666 -c 1 2>&1`;
if [[ "$check6" != *"received"* ]] && [[ "$check6" != *"transmitted"* ]];then
echo -e "\033[34m当前主机不支持IPv6,跳过...\033[0m";    

else
    test_ipv6
    yt_ipv6
    DisneyPlus_v6
fi
