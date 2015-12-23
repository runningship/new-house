package com.youwei.newhouse.entity;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;

@Entity
public class House {

	@Id
	@GeneratedValue(strategy=GenerationType.AUTO)
	public Integer id;
	
	public Integer estateId;
	
	public String dhao;
	
	public String unit;
	
	public String fhao;
	
	public Float mji;
	
	public String hxing;
	
	public Integer djia;
	
	//预付
	public Integer yufu;
	
	//实抵
	public Integer shidi;
	
	//折后总价
	public Float totalPrice;
	
	public String cxiang;
	
	public String zxiu;

	//经纪人佣金
	public Float yongjin;
	
	public Integer hasSold;
	
	public String youhuiPlan;
	
	public transient String hxingImg;
	
}
