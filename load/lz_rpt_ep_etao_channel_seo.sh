#!/bin/bash
##########################################################################
# Owner:feiqiong.dpf
# Email:feiqiong.dpf@taobao.com
# Date:2012/10/21
# ------------------------------------------------------------------------
# Description:etao频道效果seo表load
# Input: lz_rpt_ep_etao_channel_seo
# Output:
# ------------------------------------------------------------------------
# ChangeLog:
##########################################################################

ydate=`date -d -1days +%Y%m%d`
if [ $# -eq 1 ];then
    ydate=$1
fi
db_num=10000
month=`date -d "$ydate" +%Y%m`
day=`date -d "$ydate" +%d`

source $HOME/linezing/effect_platform/config/set_env.conf

python ${BranchData} lz_rpt_ep_etao_channel_seo ${hive_rpt_dir} ${rank_temp_dir} \
-bsp --noflag --field_pos=2 --range=${db_num} -d ${ydate} -o lz_rpt_ep_etao_channel_seo

if [ $? -eq 0 ]
then    
    flag_time=`ls ${rank_temp_dir}/$month/$day/lz_rpt_ep_etao_channel_seo/0001/lz_rpt_ep_etao_channel_seo.???? |cut -d. -f2`
    rm -rf ${rank_temp_dir}/$month/$day/lz_rpt_ep_etao_channel_seo/0000    
    mv ${rank_temp_dir}/$month/$day/lz_rpt_ep_etao_channel_seo/0001 ${rank_temp_dir}/$month/$day/lz_rpt_ep_etao_channel_seo/0000    
    if [ $? -eq 0 ]
    then
        touch ${rank_temp_dir}/$month/$day/lz_rpt_ep_etao_channel_seo/lz_rpt_ep_etao_channel_seo.finish
        touch ${rank_temp_dir}/$month/$day/lz_rpt_ep_etao_channel_seo/lz_rpt_ep_etao_channel_seo.${flag_time}.flag
        if [ $? -eq 0 ]
        then
            exit 0;
        else
            exit -1;
        fi
    else
        exit -1;
    fi
else    
    exit -1;
fi
