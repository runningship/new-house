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
import com.youwei.newhouse.entity.TelVerifyCode;
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
		yzm = yzm.replace(String.valueOf((char)8198), "");
		//VerifyCodeHelper.verify(yzm);
		User po = innerLogin(user);
		ThreadSession.getHttpSession().setAttribute("user", po);
		return mv;
	}
	
	public User innerLogin(User user){
		String pwd = user.pwd;
		pwd = SecurityHelper.Md5(user.pwd);
		User po = dao.getUniqueByParams(User.class, new String[]{"account" , "pwd"}, new Object[]{user.account , pwd});
		if(po==null){
			po = dao.getUniqueByParams(User.class, new String[]{"tel" , "pwd"}, new Object[]{user.tel , pwd});
		}
		if(po==null){
			throw new GException(PlatformExceptionType.BusinessException,"账号或密码不正确。");
		}
		if(po.valid==0){
			throw new GException(PlatformExceptionType.BusinessException,"账户未审核。");
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
		po.name = admin.name;
		po.landlineTel = admin.landlineTel;
		dao.saveOrUpdate(po);
		User me = ThreadSessionHelper.getUser();
		if(me.id.equals(po.id)){
			//更新session
			ThreadSession.getHttpSession().setAttribute("user", po);
		}
		return mv;
	}
	
	@WebMethod
	public ModelAndView toggleUserValidation(Integer id){
		ModelAndView mv = new ModelAndView();
		User po = dao.get(User.class, id);
		if(po!=null){
			if(po.valid>0){
				po.valid=0;
			}else{
				po.valid=1;
			}
			dao.saveOrUpdate(po);
			mv.data.put("valid", po.valid);
		}else{
			mv.data.put("valid", 0);
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
		user.addtime = new Date();
		dao.saveOrUpdate(user);
		return mv;
	}
	
	@WebMethod
	public ModelAndView doReg(User user , String verifyCode){
		ModelAndView mv = new ModelAndView();
		user.pwd = SecurityHelper.Md5(user.pwd);
		if(StringUtils.isEmpty(user.tel)){
			throw new GException(PlatformExceptionType.BusinessException,"电话号码不能为空");
		}
		User po = dao.getUniqueByKeyValue(User.class, "tel", user.tel);
		if(po!=null){
			throw new GException(PlatformExceptionType.BusinessException,"改手机号已经被注册");
		}
		TelVerifyCode tvc = VerifyCodeHelper.verifySMSCode(user.tel, verifyCode);
		tvc.verifyTime = new Date();
		dao.saveOrUpdate(tvc);
		user.addtime = new Date();
		user.account = user.tel;
		user.name = user.tel;
		user.role = Role.销售主管.toString();
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
		page.order="desc";
		page.orderBy="id";
		page = dao.findPage(page, hql.toString(), params.toArray());
		mv.data.put("page", JSONHelper.toJSON(page , DataHelper.dateSdf.toPattern()));
		return mv;
	}
}
