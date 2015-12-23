package com.youwei.newhouse.entity;

import java.util.Date;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;

//订单，预约某个具体房源
@Entity
public class HouseOrder {
	
	@Id
	@GeneratedValue(strategy=GenerationType.AUTO)
	public Integer id;
	
	public Integer estateId;
	
	public Integer hid;
	
	//经纪人
	public Integer sellerId;
	
	public String sellerName;
	
	public String status;
	
	public Date addtime;
	
	//经纪人备注
	public String sellerMark;
	
	public String buyerName;
	
	public String buyerTel;
	
	public int protect;
	
	//成交后设置
	public float yongjin;
}
