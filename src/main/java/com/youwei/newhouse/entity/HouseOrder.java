package com.youwei.newhouse.entity;

import java.util.Date;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;

//楼盘预约
@Entity
public class HouseOrder {
	
	@Id
	@GeneratedValue(strategy=GenerationType.AUTO)
	public Integer id;
	
	public Integer estateId;
	
	public String sellerName;
	
	//经纪人电话
	public String sellerTel;
	
	//当前流程到哪一步了
	public String status;
	
	//是否已带看
	public Integer daikan;
	
	public Date addtime;
	
	//经纪人备注
	public String sellerMark;
	
	public String buyerName;
	
	public String buyerTel;
	
	public String buyerGender;
	
	public Float yongjin;
}
