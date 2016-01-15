package com.youwei.newhouse.user;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang.StringUtils;
import org.bc.sdak.CommonDaoService;
import org.bc.sdak.GException;
import org.bc.sdak.Page;
import org.bc.sdak.TransactionalServiceHelper;
import org.bc.sdak.utils.JSONHelper;
import org.bc.sdak.utils.LogUtil;
import org.bc.web.ModelAndView;
import org.bc.web.Module;
import org.bc.web.PlatformExceptionType;
import org.bc.web.ThreadSession;
import org.bc.web.WebMethod;

import com.youwei.newhouse.ThreadSessionHelper;
import com.youwei.newhouse.entity.User;
import com.youwei.newhouse.util.DataHelper;
import com.youwei.newhouse.util.SecurityHelper;
import com.youwei.newhouse.util.VerifyCodeHelper;

@Module(name="/admin/user")
public class UserService {
	CommonDaoService dao = TransactionalServiceHelper.getTransactionalService(CommonDaoService.class);
	
	@WebMethod
	public ModelAndView login(User user , String yzm){
		ModelAndView mv = new ModelAndView();
		LogUtil.info("username:"+user.tel+",password="+user.pwd);
		User po = null;
		yzm = yzm.replace(String.valueOf((char)8198), "");
		if("admin".equals(user.type)){
			po = loginAsAdmin(user);
		}else{
			VerifyCodeHelper.verify(yzm);
			po = loginAsSeller(user , false);
		}
		ThreadSession.getHttpSession().setAttribute("user", po);
		return mv;
	}
	
	public User loginAsSeller(User user , boolean isMD5){
		String pwd = user.pwd;
		if(!isMD5){
			pwd = SecurityHelper.Md5(user.pwd);
		}
		List<User> list = dao.listByParams(User.class, "from User where tel=? and pwd=? and type=?", user.tel , pwd , user.type);
		User po = null;
		if(list!=null && list.size()>0){
			po = list.get(0);
		}
		if(po==null){
			throw new GException(PlatformExceptionType.BusinessException,"用户名或密码不正确。");
		}
		if(po.valid==0){
			throw new GException(PlatformExceptionType.BusinessException,"账户未审核，请电话联系为您审核。");
		}
		return po;
	}
	public User loginAsAdmin(User user){
		String pwd = SecurityHelper.Md5(user.pwd);
		User po = dao.getUniqueByParams(User.class, new String[]{"account" , "pwd"}, new Object[]{user.account  , pwd});
		if(po==null){
			throw new GException(PlatformExceptionType.BusinessException,"用户名或密码不正确。");
		}
		return po;
	}
	
	@WebMethod
	public ModelAndView adminList(){
		ModelAndView mv = new ModelAndView();
		mv.jspData.put("me", ThreadSessionHelper.getUser());
		return mv;
	}
	
	@WebMethod
	public ModelAndView adminChange(Integer id){
		ModelAndView mv = new ModelAndView();
		User seller = dao.get(User.class, id);
		mv.jspData.put("seller", seller);
		List<User> admins = dao.listByParams(User.class, "from User where type=?", "admin");
		mv.jspData.put("admins", admins);
		return mv;
	}
	
	@WebMethod
	public ModelAndView logout(){
		ModelAndView mv = new ModelAndView();
		ThreadSession.getHttpSession().removeAttribute("user");
		mv.redirect="../login.jsp";
		return mv;
	}
	
	@WebMethod
	public ModelAndView modifyPwd(String oldPwd,String newPwd){
		ModelAndView mv = new ModelAndView();
		User me = ThreadSessionHelper.getUser();
		User po = dao.get(User.class, me.id);
		if(!po.pwd.equals(SecurityHelper.Md5(oldPwd))){
			throw new GException(PlatformExceptionType.BusinessException,"原密码不正确。");
		}
		po.pwd = SecurityHelper.Md5(newPwd);
		dao.saveOrUpdate(po);
		return mv;
	}
	
	@WebMethod
	public ModelAndView updateAdmin(User admin){
		ModelAndView mv = new ModelAndView();
		User po = dao.get(User.class, admin.id);
		po.account = admin.account;
		po.role = admin.role;
		po.tel = admin.tel;
		po.email = admin.email;
		dao.saveOrUpdate(po);
		User me = ThreadSessionHelper.getUser();
		if(me.id.equals(po.id)){
			//更新session
			ThreadSession.getHttpSession().setAttribute("user", po);
		}
		return mv;
	}
	
	@WebMethod
	public ModelAndView setAdminForSeller(Integer adminId, String sellerIds){
		ModelAndView mv = new ModelAndView();
		if(StringUtils.isEmpty(sellerIds)){
			return mv;
		}
		User admin = dao.get(User.class, adminId);
		for(String id: sellerIds.split(",")){
			User seller = dao.get(User.class, Integer.valueOf(id));
			seller.adminId = adminId;
			seller.adminName = admin.account;
			seller.valid = 1;
			dao.saveOrUpdate(seller);
		}
		return mv;
	}
	
	@WebMethod
	public ModelAndView doSave(User user){
		ModelAndView mv = new ModelAndView();
		user.pwd = SecurityHelper.Md5(user.pwd);
		if(StringUtils.isEmpty(user.tel)){
			throw new GException(PlatformExceptionType.BusinessException,"电话号码不能为空");
		}
		//经纪人
		user.addtime = new Date();
		dao.saveOrUpdate(user);
		return mv;
	}
	
	
	@WebMethod
	public ModelAndView delete(Integer id){
		ModelAndView mv = new ModelAndView();
		User po = dao.get(User.class, id);
		if(po!=null){
			dao.delete(po);
		}
		return mv;
	}
	
	@WebMethod
	public ModelAndView listData(Page<User> page , String type , String city , String quyu , Integer adminId , String compName , String deptName){
		ModelAndView mv = new ModelAndView();
		StringBuilder hql = new StringBuilder("from User where 1=1 ");
		List<Object> params = new ArrayList<Object>();
		if(StringUtils.isNotEmpty(type)){
			params.add(type);
			hql.append(" and type=?");
		}
		if(StringUtils.isNotEmpty(city)){
			hql.append(" and city = ?");
			params.add(city);
		}
		if(StringUtils.isNotEmpty(quyu)){
			hql.append(" and quyu = ?");
			params.add(quyu);
		}
		if(StringUtils.isNotEmpty(compName)){
			hql.append(" and compName like ?");
			params.add("%"+compName+"%");
		}
		if(StringUtils.isNotEmpty(deptName)){
			hql.append(" and deptName like ?");
			params.add("%"+deptName+"%");
		}
		if(adminId!=null){
			hql.append(" and adminId = ?");
			params.add(adminId);
		}
		User me = ThreadSessionHelper.getUser();
		if("seller".equals(type)){
			if(Role.市场专员.toString().equals(me.role)){
				hql.append(" and adminId = ?");
				params.add(me.id);
			}
		}
		
		page.order="desc";
		page.orderBy="id";
		page = dao.findPage(page, hql.toString(), params.toArray());
		mv.data.put("page", JSONHelper.toJSON(page , DataHelper.dateSdf.toPattern()));
		return mv;
	}
}
