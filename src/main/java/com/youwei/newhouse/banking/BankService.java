package com.youwei.newhouse.banking;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Map;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import org.apache.commons.lang.StringUtils;
import org.bc.sdak.CommonDaoService;
import org.bc.sdak.GException;
import org.bc.sdak.Page;
import org.bc.sdak.TransactionalServiceHelper;
import org.bc.sdak.utils.JSONHelper;
import org.bc.web.ModelAndView;
import org.bc.web.Module;
import org.bc.web.PlatformExceptionType;
import org.bc.web.WebMethod;

import com.youwei.newhouse.ThreadSessionHelper;
import com.youwei.newhouse.banking.entity.Bank;
import com.youwei.newhouse.banking.entity.BankLabel;
import com.youwei.newhouse.banking.entity.LoanOrder;
import com.youwei.newhouse.entity.User;

@Module(name="/admin/bank")
public class BankService {

	CommonDaoService dao = TransactionalServiceHelper.getTransactionalService(CommonDaoService.class);

	@WebMethod
	public ModelAndView add(Bank bank){
		ModelAndView mv = new ModelAndView();
		User u = ThreadSessionHelper.getUser();
		Bank po = dao.getUniqueByKeyValue(Bank.class, "managerUid", u.id);
		if(po==null){
			bank.managerUid =u.id;
			dao.saveOrUpdate(bank);
		}else{
			po.name = bank.name;
			po.biz = bank.biz;
			dao.saveOrUpdate(po);
		}
		return mv;
	}
	
	@WebMethod
	public ModelAndView addLabel(BankLabel label){
		ModelAndView mv = new ModelAndView();
		BankLabel po = dao.get(BankLabel.class, label.id);
		if(po!=null){
			po.title = label.title;
			po.conts = label.conts;
			dao.saveOrUpdate(po);
		}else{
			dao.saveOrUpdate(label);
		}
		return mv;
	}
	
	@WebMethod
	public ModelAndView deleteLabel(Integer id){
		ModelAndView mv = new ModelAndView();
		BankLabel po = dao.get(BankLabel.class, id);
		if(po!=null){
			dao.delete(po);
		}
		return mv;
	}
	
	@WebMethod
	public ModelAndView list(Page<Map> page , String bankName , String tel){
		ModelAndView mv = new ModelAndView();
		StringBuilder hql = new StringBuilder();
		List<Object> params = new ArrayList<Object>();
		hql.append("select bank.name as subBankName , bank.biz as biz ,u.name as bankName,u.tel as tel from Bank bank , User u where bank.managerUid=u.id");
		if(StringUtils.isNotEmpty(bankName)){
			hql.append(" and u.name like ? ");
			params.add("%"+bankName+"%");
		}
		
		if(StringUtils.isNotEmpty(tel)){
			hql.append(" and u.tel like ? ");
			params.add("%"+tel+"%");
		}
		
		page = dao.findPage(page, hql.toString() , true , params.toArray());
		mv.data.put("page", JSONHelper.toJSON(page));
		return mv;
	}
	
	@WebMethod
	public ModelAndView addOrder(LoanOrder order){
		ModelAndView mv = new ModelAndView();
		if(StringUtils.isEmpty(order.area)){
			throw new GException(PlatformExceptionType.BusinessException, "请先填写小区信息");
		}
		if(order.mji==null){
			throw new GException(PlatformExceptionType.BusinessException, "请先填写房源面积信息");
		}
		if(order.zjia==null){
			throw new GException(PlatformExceptionType.BusinessException, "请先填写房源总价");
		}
		if(order.loan==null){
			throw new GException(PlatformExceptionType.BusinessException, "请先填写贷款金额");
		}
		
		order.addtime = new Date();
		order.status = 1;
		dao.saveOrUpdate(order);
		mv.data.put("result", "1");
		return mv;
	}
	
	@WebMethod
	public ModelAndView setStatus(Integer id , int status){
		ModelAndView mv = new ModelAndView();
		LoanOrder po = dao.get(LoanOrder.class, id);
		po.status = status;
		dao.saveOrUpdate(po);
		mv.data.put("result", "1");
		return mv;
	}
	
	@WebMethod
	public ModelAndView listAllOrder(Page<Map> page , Integer status , String bankName , String sellerTel , String area){
		ModelAndView mv = new ModelAndView();
		StringBuilder sql = new StringBuilder();
		sql.append("select bank.name as bankName, loanOrder.id as id , loanOrder.area as area, loanOrder.zjia as zjia, loanOrder.mji as mji ,loanOrder.loan as loan , loanOrder.comp as comp , loanOrder.sellerTel as sellerTel,"
				+ " loanOrder.sellerName as sellerName, loanOrder.status as status from LoanOrder loanOrder ,Bank bank where bank.id=loanOrder.bankId  ");
		List<Object> params = new ArrayList<Object>();
		if(status!=null){
			sql.append(" and status = ?");
			params.add(status);
		}
		if(StringUtils.isNotEmpty(bankName)){
			sql.append(" and bank.name like ?");
			params.add("%"+bankName+"%");
		}
		if(StringUtils.isNotEmpty(sellerTel)){
			sql.append(" and sellerTel like ?");
			params.add("%"+sellerTel+"%");
		}
		if(StringUtils.isNotEmpty(area)){
			sql.append(" and area like ?");
			params.add("%"+area+"%");
		}
		page = dao.findPage(page, sql.toString() ,true , params.toArray());
		mv.data.put("page", JSONHelper.toJSON(page));
		return mv;
	}
	
	@WebMethod
	public ModelAndView listOrder(Page<LoanOrder> page , Integer status){
		ModelAndView mv = new ModelAndView();
		StringBuilder sql = new StringBuilder();
		Bank bank = dao.getUniqueByKeyValue(Bank.class, "managerUid", ThreadSessionHelper.getUser().id);
		sql.append("from LoanOrder where bankId =?  ");
		List<Object> params = new ArrayList<Object>();
		if(bank!=null){
			params.add(bank.id);
		}else{
			params.add(-1);
		}
		if(status!=null){
			sql.append(" and status = ?");
			params.add(status);
		}
		page = dao.findPage(page, sql.toString() , params.toArray());
		mv.data.put("page", JSONHelper.toJSON(page));
		return mv;
	}
	
	@WebMethod
	public ModelAndView deleteOrder(Integer id){
		ModelAndView mv = new ModelAndView();
		LoanOrder po = dao.get(LoanOrder.class, id);
		if(po!=null){
			dao.delete(po);
		}
		return mv;
	}
}
