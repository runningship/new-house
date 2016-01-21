package com.youwei.newhouse.entity;

import java.util.Date;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table(name="uc_user")
public class User {

	@Id
	@GeneratedValue(strategy=GenerationType.AUTO)
	public Integer id;
	
	public String name;
	
	public String account;
	
	public String pwd;
	
	public String tel;
	
	public Date addtime;
	
	public Date lasttime;
	
	public String role;
	
	public String email;
	
	//是否通过审核
	public int valid;
	
	public String province;
	
	public String city;
	
	public String quyu;
	
	public String activeCode;
	
	//固定电话
	public String landlineTel;
	
}
