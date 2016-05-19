//
//  CONST.h
//  guoping
//
//  Created by zhisu on 15/9/2.
//  Copyright (c) 2015年 zhisu. All rights reserved.
//

#ifndef guoping_CONST_h
#define guoping_CONST_h



//Boss登录
#define SysLoginUrl  "http://192.168.8.113:8006/UserWebService.asmx/SysLogin"

//首页
#define AppHomeUrl "http://192.168.8.113:8006/UserWebService.asmx/AppHome"

//销售信息页
#define GetSaleListByPageUrl "http://192.168.8.113:8006/UserWebService.asmx/GetSaleListByPage"

//销售页总金额
#define GetSaleTotalMoneyUrl "http://192.168.8.113:8006/UserWebService.asmx?op=GetSaleTotalMoney"

//销售单详细
#define GetSaleDetailInfoUrl "http://192.168.8.113:8006/UserWebService.asmx/GetSaleDetailInfo"

//库存查询
#define GetGoodsInventoryListByPageUrl "http://192.168.8.113:8006/UserWebService.asmx/GetGoodsInventoryListByPage"

//库存查询详细
#define GetGoodsInventoryDetailInfoUrl "http://192.168.8.113:8006/UserWebService.asmx/GetGoodsInventoryDetailInfo"

//报损信息
#define GetWastageListByPageUrl "http://192.168.8.113:8006/UserWebService.asmx/GetWastageListByPage"

//要货信息
#define GetStoreNeedOrderListByPageUrl "http://192.168.8.113:8006/UserWebService.asmx/GetStoreNeedOrderListByPage"

//商品管理
#define GetGoodsListByPageUrl "http://192.168.8.113:8006/UserWebService.asmx/GetGoodsListByPage"

//进货信息
#define GetStoreIncomeListByPageUrl "http://192.168.8.113:8006/UserWebService.asmx/GetStoreIncomeListByPage"
//进货详细
#define GetStoreIncomeDetailInfoUrl "http://192.168.8.113:8006/UserWebService.asmx/GetStoreIncomeDetailInfo"

//要货单详情
#define GetStoreNeedOrderDetailInfoUrl "http://192.168.8.113:8006/UserWebService.asmx/GetStoreNeedOrderDetailInfo"

//商品详细
#define GetGoodsInfoByIdUrl "http://192.168.8.113:8006/UserWebService.asmx/GetGoodsInfoById"

//店铺排行
#define GetStoreSaleTop10Url "http://192.168.8.113:8006/UserWebService.asmx/GetStoreSaleTop10"

//合计金额
#define MoneyUrl "http://192.168.8.113:8006/UserWebService.asmx/GetSaleTotalMoney"

//商品状态
#define UpdateGoodsStateByIdUrl "http://192.168.8.113:8006/UserWebService.asmx/UpdateGoodsStateById"


//全部店铺
#define GetAllStoreListUrl "http://192.168.8.113:8006/UserWebService.asmx/GetAllStoreList"

//信息页 笔数
#define GetSaleRecordCountUrl "http://192.168.8.113:8006/UserWebService.asmx/GetSaleRecordCount"

//搜索
#define GetGoodsInfoLisByPageUrl "http://192.168.8.113:8006/UserWebService.asmx/GetGoodsInfoLisByPage"

//修改售价
#define UpdateGoodsPriceByIdUrl "http://192.168.8.113:8006/UserWebService.asmx/UpdateGoodsPriceById"

//全部商品种类
#define GetGoodsTypeListUrl "http://192.168.8.113:8006/UserWebService.asmx/GetGoodsTypeList"

//所属主商品
#define GetGoodNot2LeaveListUrl "http://192.168.8.113:8006/UserWebService.asmx/GetGoodNot2LeaveList"

//度量单位
#define GetUnitListUrl "http://192.168.8.113:8006/UserWebService.asmx/GetUnitList"


//新增商品
#define AddGoodsUrl "http://192.168.8.113:8006/UserWebService.asmx/AddGoods"


//全部省份
#define GetProvinceListUrl "http://192.168.8.113:8006/UserWebService.asmx/GetProvinceList"


//根据省份查城市
#define GetCityListUrl "http://192.168.8.113:8006/UserWebService.asmx/GetCityList"


//根据城市查区
#define GetAreaListUrl "http://192.168.8.113:8006/UserWebService.asmx/GetAreaList"


//全部会员卡类型
#define GetAllCardTypeToListUrl "http://192.168.8.113:8006/UserWebService.asmx/GetAllCardTypeToList"


//全部会员卡信息
#define GetAllMemberCardToListUrl "http://192.168.8.113:8006/UserWebService.asmx/GetAllMemberCardToList"

//输入参数entId（企业ID）/storeId（店铺ID）/cardType(卡类型)/currPageIndex(当前页码)/pageSize(页面大小，不分页传-1)/code（授权码）



#endif
