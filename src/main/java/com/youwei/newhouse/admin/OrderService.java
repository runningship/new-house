package com.youwei.newhouse.admin;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang.StringUtils;
import org.apache.log4j.Level;
import org.bc.sdak.CommonDaoService;
import org.bc.sdak.GException;
import org.bc.sdak.Page;
import org.bc.sdak.Transactional;
import org.bc.sdak.TransactionalServiceHelper;
import org.bc.sdak.utils.JSONHelper;
import org.bc.sdak.utils.LogUtil;
import org.bc.web.ModelAndView;
import org.bc.web.Module;
import org.bc.web.PlatformExceptionType;
import org.bc.web.ThreadSession;
import org.bc.web.WebMethod;

import com.youwei.newhouse.Constants;
import com.youwei.newhouse.ThreadSessionHelper;
import com.youwei.newhouse.entity.Estate;
import com.youwei.newhouse.entity.HouseOrder;
import com.youwei.newhouse.entity.OrderGenJin;
import com.youwei.newhouse.entity.User;
import com.youwei.newhouse.util.DataHelper;
import com.youwei.newhouse.util.ShortMessageHelper;

@Module(name="/admin/order")
public class OrderService {

	CommonDaoService dao = TransactionalServiceHelper.getTransactionalService(CommonDaoService.class);
	
	@WebMethod
	@Transactional
	public ModelAndView update(HouseOrder order){
		ModelAndView mv = new ModelAndView();
		HouseOrder po = dao.get(HouseOrder.class, order.id);
//		if(Constants.HouseOrderJieYong.equals(po.status)){
//			throw new GException(PlatformExceptionType.BusinessException,"已结佣，状态不可更改");
//		}
		if(!order.status.equals(po.status)){
			if(!Constants.HouseOrderJieYong.equals(po.status)){
				po.status = order.status;
			}
			//add genjin
			OrderGenJin genjin = new OrderGenJin();
			genjin.addtime = new Date();
			genjin.conts="";
			genjin.uname = ThreadSessionHelper.getUser().name;
			genjin.status = order.status;
			genjin.orderId = po.id;
			dao.saveOrUpdate(genjin);
			if(Constants.HouseOrderJieYong.equals(order.status)){
				Estate estate = dao.get(Estate.class, po.estateId);
				if(estate.jieyongCount==null){
					estate.jieyongCount = 1;
				}else{
					estate.jieyongCount++;
				}
				if(estate.yongjinTotal==null){
					estate.yongjinTotal = order.yongjin;
				}else{
					estate.yongjinTotal+=order.yongjin;
				}
			}
		}
		po.yongjin = order.yongjin;
		//po.status = order.status;
		po.daikan = order.daikan;
		po.sellerMark = order.sellerMark;
		dao.saveOrUpdate(po);
		return mv;
	}
	
	@WebMethod
	@Transactional
	public ModelAndView setStatus(Integer orderId , Integer uid ,String status){
		ModelAndView mv = new ModelAndView();
		User user = dao.get(User.class, uid);
		HouseOrder po = dao.get(HouseOrder.class, orderId);
		if(po!=null){
			po.status = status;
			dao.saveOrUpdate(po);
			OrderGenJin genjin = new OrderGenJin();
			genjin.addtime = new Date();
			genjin.conts="";
			genjin.uname = user.name;
			genjin.status = status;
			genjin.orderId = po.id;
			dao.saveOrUpdate(genjin);
			if(Constants.HouseOrderJieYong.equals(status)){
				Estate estate = dao.get(Estate.class, po.estateId);
				if(estate.jieyongCount==null){
					estate.jieyongCount = 1;
				}else{
					estate.jieyongCount++;
				}
				if(estate.yongjinTotal==null){
					estate.yongjinTotal = po.yongjin;
				}else{
					estate.yongjinTotal+=po.yongjin;
				}
			}
		}
		return mv;
	}
	@WebMethod
	public ModelAndView doSave(HouseOrder order , String estateIds){
		ModelAndView mv = new ModelAndView();
		
		for(String estateId : estateIds.split(",")){
			if(StringUtils.isEmpty(estateId)){
				continue;
			}
			long count = dao.countHql("select count(*) from HouseOrder where buyerTel=? and estateId=? ", order.buyerTel ,Integer.valueOf(estateId));
			if(count>0){
				Estate estate = dao.get(Estate.class, Integer.valueOf(estateId));
				throw new GException(PlatformExceptionType.BusinessException, "您已经为该客户推荐过"+estate.name+"，请不要重复推荐");
			}
		}
		order.addtime = new Date();
		for(String estateId : estateIds.split(",")){
			if(StringUtils.isEmpty(estateId)){
				continue;
			}
			HouseOrder ho = new HouseOrder();
			ho.addtime = new Date();
			ho.buyerGender = order.buyerGender;
			ho.buyerName = order.buyerName;
			ho.buyerTel = order.buyerTel;
			ho.sellerName = order.sellerName;
			ho.sellerTel = order.sellerTel;
			ho.status = Constants.HouseOrderConfirming;
			ho.estateId = Integer.valueOf(estateId);
			dao.saveOrUpdate(ho);
			try{
				Estate estate = dao.get(Estate.class, ho.estateId);
				User manager = dao.get(User.class, estate.managerUid);
				ShortMessageHelper.sendNewOrderMsg(manager.tel);
			}catch(Exception ex){
				LogUtil.log(Level.WARN,"发送短信提示失败" , ex);
			}
		}
		return mv;
	}
	
//	@WebMethod
//	public ModelAndView fankui(OrderGenJin genjin){
//		ModelAndView mv = new ModelAndView();
//		genjin.addtime = new Date();
//		dao.saveOrUpdate(genjin);
//		mv.data.put("genjin", JSONHelper.toJSON(genjin , DataHelper.sdf3.toPattern()));
//		return mv;
//	}
	
//	@WebMethod
//	public ModelAndView accept(Integer id){
//		ModelAndView mv = new ModelAndView();
//		HouseOrder po = dao.get(HouseOrder.class, id);
//		po.status = Constants.HouseOrderValid;
//		return mv;
//	}
//	
//	@WebMethod
//	public ModelAndView deal(Integer id){
//		ModelAndView mv = new ModelAndView();
//		HouseOrder po = dao.get(HouseOrder.class, id);
//		po.status = Constants.HouseOrderDeal;
//		return mv;
//	}
	
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
		StringBuilder hql = new StringBuilder("select  order.id as id, est.name as estateName, order.buyerName as buyerName ,order.buyerTel as buyerTel, "
				+ " order.sellerName as sellerName ,order.buyerGender as buyerGender ,order.sellerTel as sellerTel, order.addtime as addtime, order.status as status ,order.daikan as daikan from HouseOrder order, "
				+ "Estate est where order.estateId=est.id ");
		List<Object> params = new ArrayList<Object>();
		setQuery(hql, params , query);
		page.order="desc";
		page.orderBy = "order.addtime";
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
		if(query.managerUid!=null){
			hql.append(" and est.managerUid=?");
			params.add(query.managerUid);
		}
		if(StringUtils.isNotEmpty(query.buyerName)){
			hql.append(" and order.buyerName like ?");
			params.add("%"+query.buyerName+"%");
		}
		if(StringUtils.isNotEmpty(query.buyerTel)){
			hql.append(" and order.buyerTel like ?");
			params.add("%"+query.buyerTel+"%");
		}
		if(StringUtils.isNotEmpty(query.status)){
			hql.append(" and order.status = ?");
			params.add(query.status);
		}
		if(StringUtils.isNotEmpty(query.estateName)){
			hql.append(" and est.name like ?");
			params.add("%"+query.estateName+"%");
		}
		if(StringUtils.isNotEmpty(query.sellerName)){
			hql.append(" and order.sellerName like ?");
			params.add("%"+query.sellerName+"%");
		}
		if(StringUtils.isNotEmpty(query.sellerTel)){
			hql.append(" and order.sellerTel like ?");
			params.add("%"+query.sellerTel+"%");
		}
		
		if(StringUtils.isNotEmpty(query.quyu)){
			hql.append(" and quyu like ?");
			params.add("%"+query.quyu+"%");
		}
		if(StringUtils.isNotEmpty(query.city)){
			hql.append(" and city like ?");
			params.add("%"+query.city+"%");
		}
	}
}
