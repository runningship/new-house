package com.youwei.newhouse.banking.entity;

import java.util.Date;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;

@Entity
public class LoanOrder {

	@Id
	@GeneratedValue(strategy=GenerationType.AUTO)
	public Integer id;
	
	public Integer bankId;
	
	public String area;
	
	public Float mji;
	
	public Float zjia;
	
	public Float loan;
	
	public String comp;
	
	public String sellerName;
	
	public String sellerTel;
	
	//1 待确认，2已确认 3已忽略
	public Integer status;
	
	public Date addtime;
}
