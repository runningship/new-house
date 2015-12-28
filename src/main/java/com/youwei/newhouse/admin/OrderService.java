package com.youwei.newhouse.admin;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang.StringUtils;
import org.bc.sdak.CommonDaoService;
import org.bc.sdak.Page;
import org.bc.sdak.Transactional;
import org.bc.sdak.TransactionalServiceHelper;
import org.bc.sdak.utils.JSONHelper;
import org.bc.web.ModelAndView;
import org.bc.web.Module;
import org.bc.web.ThreadSession;
import org.bc.web.WebMethod;

import com.youwei.newhouse.Constants;
import com.youwei.newhouse.entity.Estate;
import com.youwei.newhouse.entity.HouseOrder;
import com.youwei.newhouse.entity.OrderGenJin;
import com.youwei.newhouse.entity.User;
import com.youwei.newhouse.util.DataHelper;

@Module(name="/admin/order")
public class OrderService {

	CommonDaoService dao = TransactionalServiceHelper.getTransactionalService(CommonDaoService.class);
	
	@WebMethod
	public ModelAndView list(){
		ModelAndView mv = new ModelAndView();
		return mv;
	}
	
	@WebMethod
	public ModelAndView add(){
		ModelAndView mv = new ModelAndView();
		return mv;
	}
	
	@WebMethod
	@Transactional
	public ModelAndView update(HouseOrder order){
		ModelAndView mv = new ModelAndView();
		HouseOrder po = dao.get(HouseOrder.class, order.id);
		po.status = order.status;
		po.yongjin = order.yongjin;
		po.sellerMark = order.sellerMark;
		dao.saveOrUpdate(po);
		return mv;
	}
	
	@WebMethod
	public ModelAndView doSave(HouseOrder order , String yzm){
//		VerifyCodeHelper.verify(yzm);
		order.status = Constants.HouseOrderConfirming;
		ModelAndView mv = new ModelAndView();
		order.addtime = new Date();
		dao.saveOrUpdate(order);
		return mv;
	}
	
	@WebMethod
	public ModelAndView fankui(OrderGenJin genjin){
		ModelAndView mv = new ModelAndView();
		genjin.addtime = new Date();
		dao.saveOrUpdate(genjin);
		mv.data.put("genjin", JSONHelper.toJSON(genjin , DataHelper.sdf3.toPattern()));
		return mv;
	}
	
	@WebMethod
	public ModelAndView accept(Integer id){
		ModelAndView mv = new ModelAndView();
		HouseOrder po = dao.get(HouseOrder.class, id);
		po.status = Constants.HouseOrderValid;
		return mv;
	}
	
	@WebMethod
	public ModelAndView deal(Integer id){
		ModelAndView mv = new ModelAndView();
		HouseOrder po = dao.get(HouseOrder.class, id);
		po.status = Constants.HouseOrderDeal;
		return mv;
	}
	
	@WebMethod
	public ModelAndView delete(Integer id){
		ModelAndView mv = new ModelAndView();
		HouseOrder po = dao.get(HouseOrder.class, id);
		if(po!=null){
			dao.delete(po);
		}
		return mv;
	}
	
	@WebMethod
	public ModelAndView deleteAll(String ids){
		ModelAndView mv = new ModelAndView();
		StringBuilder hql = new StringBuilder("delete from HouseOrder where id in (").append(ids).append(")");
		dao.execute(hql.toString());
		return mv;
	}
	
	@WebMethod
	public ModelAndView listEstateData(Page<Map> page ,OrderQuery query){
		ModelAndView mv = new ModelAndView();
		StringBuilder hql = new StringBuilder("select  order.id as id, est.name as estateName, order.buyerName as buyerName ,order.buyerTel as buyerTel,order.protect as protect,"
				+ " order.sellerName as sellerName , order.addtime as addtime, order.status as status from HouseOrder order, "
				+ "Estate est where order.estateId=est.id ");
		List<Object> params = new ArrayList<Object>();
		setQuery(hql, params , query);
		page.order="desc";
		page.order = "order.addtime";
		page = dao.findPage(page, hql.toString(), true,params.toArray());
		mv.data.put("page", JSONHelper.toJSON(page , DataHelper.dateSdf.toPattern()));
		return mv;
	}
	
	private void setQuery(StringBuilder hql , List<Object> params ,OrderQuery query){
		if(query.estateId!=null){
			hql.append(" and estateId=?");
			params.add(query.estateId);
		}
		if(query.sellerId!=null){
			hql.append(" and order.sellerId=?");
			params.add(query.sellerId);
		}
		if(StringUtils.isNotEmpty(query.buyerName)){
			hql.append(" and order.buyerName like ?");
			params.add("%"+query.buyerName+"%");
		}
		if(StringUtils.isNotEmpty(query.buyerTel)){
			hql.append(" and order.buyerTel like ?");
			params.add("%"+query.buyerTel+"%");
		}
		if(StringUtils.isNotEmpty(query.estateName)){
			hql.append(" and est.name like ?");
			params.add("%"+query.estateName+"%");
		}
		if(StringUtils.isNotEmpty(query.sellerName)){
			hql.append(" and order.sellerName like ?");
			params.add("%"+query.sellerName+"%");
		}
	}
}
