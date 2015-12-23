package com.youwei.newhouse.entity;

import java.util.Date;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;

@Entity
public class Estate {
	
	@Id
	@GeneratedValue(strategy=GenerationType.AUTO)
	public Integer id;
	
	public String quyu;
	
	public String name;
	
	public String tel;
	
	public String addr;
	
	public Date opentime;
	
	//建筑类型，楼型
	public String lxing;
	
	public String zxiu;
	
	//均价,房金宝的价格
	public String junjia;
	//物业类型
	public String wylx;
	
	//建筑面积
	public String jzmj;
	
	//规划面积
	public String ghmj;
	
	//容积率
	public Float rongji;
	
	//绿化率
	public Float lvhua;
	
	public String chewei;
	
	//户数
	public Integer hushu;
	
	//物业费
	public String wyfee;
	
	//特色
	public String tese;
	
	//开发商
	public String developer;
	
	//物业公司
	public String wyComp;
	
	//可预约数量
	public Integer unSold;
	
	//总价
	public Float totalPrice;
	
//	public Float yongjin;
	
	//特惠价
	public String tejia;
	
	//预付
	public Integer yufu;
	
	//实抵
	public Integer shidi;
	
	public Date youhuiEndtime;
	
	//是否推荐
	public Integer tuijian;
	
	//住图片
	public String img;
	
	//1限时特惠
	public Integer tehui;
	
	public String uuid;
	
	public Float jingdu;
	
	public Float weidu;
	
	public String city;
	
	public String province;
	
	//即将推出，文字性描述 
	public String jjtc;
	
	//公摊
	public Float gongtan;
	
	//产权,土地年限
	public String chanquan;
	
	//售楼部地址
	public String shouloubu;
	
	//销售许可证
	public String xukezheng;
	
	//产权归属
	public String guishu;
	
	//代理商
	public String daili;
	
	//公积金贷款
	public String gongjijin;
	
	//付款方式
	public String fukuang;
	
	//交房日期
	public Date jiaofangDate;
	
	//主力户型
	public String mainHuxing;
	
	public String jieshao;
	
	//优惠方案
	public String youhuiPlan;
	//项目经理
	public String manager;
	
	public int orderx;
	
	public String yongjin;
}
