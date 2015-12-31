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
	
	//均价
	public String junjia;
	//物业类型
	public String wylx;
	
	//绿化率
	public Float lvhua;
	
	//物业费
	public String wyfee;
	
	//开发商
	public String developer;
	
	//是否推荐
	public Integer tuijian;
	
	public String uuid;
	
	public String city;
	
	public String province;
	
	//公摊
	public Float gongtan;
	
	//产权归属
	public String guishu;
	
	//交房日期
	public Date jiaofangDate;
	
	public String shenghuo;
	
	public String xuequ;
	
	public String mainHuxing;
	
	public String tese;
	
	public String jiaotong;
	
	public int orderx;
	
	public String yongjin;
}
