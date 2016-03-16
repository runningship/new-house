package com.youwei.newhouse.banking;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import org.bc.sdak.CommonDaoService;
import org.bc.sdak.Page;
import org.bc.sdak.TransactionalServiceHelper;
import org.bc.sdak.utils.JSONHelper;
import org.bc.web.ModelAndView;
import org.bc.web.Module;
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
	public ModelAndView list(Page<Bank> page){
		ModelAndView mv = new ModelAndView();
		page = dao.findPage(page, "from Bank");
		mv.data.put("page", JSONHelper.toJSON(page));
		return mv;
	}
	
	@WebMethod
	public ModelAndView addOrder(LoanOrder order){
		ModelAndView mv = new ModelAndView();
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
	public ModelAndView listOrder(Page<LoanOrder> page , Integer status){
		ModelAndView mv = new ModelAndView();
		StringBuilder sql = new StringBuilder();
		sql.append("from LoanOrder where 1=1 ");
		List<Object> params = new ArrayList<Object>();
		if(status!=null){
			sql.append(" and status = ?");
			params.add(status);
		}
		page = dao.findPage(page, sql.toString() , params.toArray());
		mv.data.put("page", JSONHelper.toJSON(page));
		return mv;
	}
}
