package com.youwei.newhouse.entity;

import java.util.Date;

import javax.persistence.Entity;
import javax.persistence.Id;

@Entity
public class KanFang {

	@Id
	public Integer id;
	
	public Integer orderId;
	
	public Date seetime;
	
	public String beizhu;
}
