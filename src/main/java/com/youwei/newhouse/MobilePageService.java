package com.youwei.newhouse;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.servlet.http.Cookie;

import org.apache.commons.lang.StringUtils;
import org.bc.sdak.CommonDaoService;
import org.bc.sdak.Page;
import org.bc.sdak.TransactionalServiceHelper;
import org.bc.sdak.utils.JSONHelper;
import org.bc.web.ModelAndView;
import org.bc.web.Module;
import org.bc.web.ThreadSession;
import org.bc.web.WebMethod;

import com.youwei.newhouse.admin.EstateQuery;
import com.youwei.newhouse.entity.Article;
import com.youwei.newhouse.entity.Estate;
import com.youwei.newhouse.entity.HouseImage;
import com.youwei.newhouse.entity.HouseOrder;
import com.youwei.newhouse.entity.OrderGenJin;
import com.youwei.newhouse.entity.User;
import com.youwei.newhouse.util.ConfigHelper;
import com.youwei.newhouse.util.DataHelper;

@Module(name="/m/")
public class MobilePageService {

	CommonDaoService dao = TransactionalServiceHelper.getTransactionalService(CommonDaoService.class);
	
	@WebMethod
	public ModelAndView index(){
		ModelAndView mv = new ModelAndView();
//		ThreadSession.getHttpSession().setAttribute(FjbConstant.Session_Attr_City, "合肥");
		long total = dao.countHql("select count(*) from Estate where city=?",ThreadSessionHelper.getCity() );
		mv.jspData.put("total", total);
		
		//最大优惠
		Page<Map> page2 = new Page<Map>();
		page2.setPageSize(1);
		page2 = dao.findPage(page2, "select (h.shidi-h.yufu) as youhui from Estate est, House h where h.estateId=est.id and est.city=? order by youhui desc", true , new Object[]{ThreadSessionHelper.getCity()});
		if(!page2.getResult().isEmpty()){
			mv.jspData.put("maxYouhui", page2.getResult().get(0).get("youhui"));
		}
		return mv;
	}
	
	@WebMethod
	public ModelAndView sellerIndex(){
		ModelAndView mv = new ModelAndView();
		User seller = ThreadSessionHelper.getUser();
		HouseImage img = dao.getUniqueByParams(HouseImage.class, new String[]{"estateUUID" , "type"}, new Object[]{seller.id.toString() , "touxiang"});
		mv.jspData.put("touxiang", img==null ? "" : img.path);
		return mv;
	}
	
	@WebMethod
	public ModelAndView listIndexData(Page<Map> page , String quyu){
		ModelAndView mv = new ModelAndView();
		StringBuilder hql = new StringBuilder("select est.id as id, est.name as name , est.quyu as quyu , est.addr as addr, est.junjia as junjia , est.youhuiPlan as youhuiPlan,"
				+ "est.tel as tel,img.path as img , est.yufu as yufu , est.shidi as shidi from Estate est,HouseImage img"
				+ " where est.uuid=img.estateUUID and est.tuijian=1 and est.city=? and img.type='main'");
		List<String> params = new ArrayList<String>();
		params.add(ThreadSessionHelper.getCity());
		if(StringUtils.isNotEmpty(quyu)){
			hql.append(" and est.quyu=? ");
			params.add(quyu);
		}
		page.setPageSize(10);
		page.order="desc";
		page.orderBy = "est.orderx";
		page = dao.findPage(page, hql.toString(), true, params.toArray());
		mv.data.put("page", JSONHelper.toJSON(page , DataHelper.dateSdf.toPattern()));
		return mv;
	}
	
	
	@WebMethod
	public ModelAndView sales(Page<Map> page){
		ModelAndView mv = new ModelAndView();
		mv = ConfigHelper.queryItems(mv);
		
		for(Map map : page.getResult()){
			//预约数量
			long count = dao.countHql("select count(*) from HouseOrder where estateId=?", map.get("id"));
			map.put("orderCount", count);
		}
		return mv;
	}
	
	@WebMethod
	public ModelAndView listSalesData(Page<Map> page , String quyu){
		ModelAndView mv = new ModelAndView();
		StringBuilder hql = new StringBuilder("select est.id as id, est.uuid as uuid, est.name as name , est.quyu as quyu ,est.tejia as tejia , est.junjia as junjia , est.yongjin as yongjin,"
				+ " est.opentime as opendate, est.addr as addr , img.path as img from Estate est,"
				+ "HouseImage img where est.uuid=img.estateUUID and img.type='main'");
		List<String> params = new ArrayList<String>();
		params.add(ThreadSessionHelper.getCity());
		if(StringUtils.isNotEmpty(quyu)){
			hql.append(" and est.quyu=? ");
			params.add(quyu);
		}
		page.setPageSize(10);
		page.order="desc";
		page.orderBy = "est.orderx";
		page = dao.findPage(page, hql.toString(), true,new Object[]{});
		mv.data.put("page", JSONHelper.toJSON(page , DataHelper.dateSdf.toPattern()));
		return mv;
	}
	
	
	@WebMethod
	public ModelAndView houses(Page<Map> page , EstateQuery query){
		ModelAndView mv = new ModelAndView();
		mv = ConfigHelper.queryItems(mv);
		mv.jspData.put("selectedQuyu", query.quyu);
		mv.jspData.put("selectedLxing",query.lxing);
		mv.jspData.put("searchText", query.searchText);
		mv.jspData.put("jiageStart", query.jiageStart);
		mv.jspData.put("jiageEnd", query.jiageEnd);
		return mv;
	}
	
	@WebMethod
	public ModelAndView listHousesData(Page<Map> page , EstateQuery query){
		ModelAndView mv = new ModelAndView();
		List<Object> params = new ArrayList<Object>();
		params.add(ThreadSessionHelper.getCity());
		page.setPageSize(10);
		page.order="desc";
		page.orderBy = "est.id";
		StringBuilder hql = new StringBuilder("select est.id as id, est.name as name , est.quyu as quyu ,est.tejia as tejia , est.junjia as junjia , est.tel as tel, est.youhuiPlan as youhuiPlan,"
				+ "  est.opentime as opendate, est.addr as addr,  est.yufu as yufu, est.shidi as shidi , img.path as img from Estate est,"
				+ "HouseImage img where est.uuid=img.estateUUID and est.city=? and img.type='main'");
		if(StringUtils.isNotEmpty(query.quyu)){
			hql.append(" and est.quyu=?");
			params.add(query.quyu);
		}
		if(StringUtils.isNotEmpty(query.lxing)){
			hql.append(" and est.lxing like ?");
			params.add("%"+query.lxing+"%");
		}
		if(StringUtils.isNotEmpty(query.searchText)){
			hql.append(" and est.name like ?");
			params.add("%"+query.searchText+"%");
		}
		if(query.jiageStart!=null){
			hql.append(" and est.junjia>=?");
			params.add(query.jiageStart);
		}
		if(query.jiageEnd!=null){
			hql.append(" and est.junjia<=?");
			params.add(query.jiageEnd);
		}
		page = dao.findPage(page, hql.toString() , true, params.toArray());
		mv.data.put("page", JSONHelper.toJSON(page , DataHelper.dateSdf.toPattern()));
		return mv;
	}
	
	@WebMethod
	public ModelAndView info(Integer estateId){
		ModelAndView mv = new ModelAndView();
		Estate po = dao.get(Estate.class, estateId);
		mv.data.put("estate", po);
		
//		HouseImage mainImg = dao.getUniqueByParams(HouseImage.class, new String[]{"estateUUID" ,"type"}, new Object[]{po.uuid , FjbConstant.Main});
//		if(mainImg!=null){
//			mv.jspData.put("main_img", mainImg.path);
//		}
		//户型图
		List<HouseImage> hxImgList = dao.listByParams(HouseImage.class, "from HouseImage where estateUUID=? and type=? ", po.uuid , Constants.HuXing);
		List<HouseImage> xgImgList = dao.listByParams(HouseImage.class, "from HouseImage where estateUUID=? and type=? ", po.uuid , Constants.XiaoGuo);
		mv.data.put("hxImgList", JSONHelper.toJSONArray(hxImgList));
		mv.data.put("xgImgList", JSONHelper.toJSONArray(xgImgList));
		
		return mv;
	}
	
	@WebMethod
	public ModelAndView seePic(Integer estateId ,String type){
		ModelAndView mv = new ModelAndView();
		Estate po = dao.get(Estate.class, estateId);
		StringBuilder hql = new StringBuilder("from HouseImage where estateUUID=?");
		List<Object> params = new ArrayList<Object>();
		params.add(po.uuid);
		if(StringUtils.isNotEmpty(type)){
			hql.append(" and type=?");
			params.add(type);
		}
		List<HouseImage> images = dao.listByParams(HouseImage.class, hql.toString(), params.toArray());
		mv.jspData.put("images", images);
		return mv;
	}
	
	@WebMethod
	public ModelAndView houseMap(){
		ModelAndView mv = new ModelAndView();
		List<Map> list = dao.listAsMap("select name as name, jingdu as jingdu , weidu as weidu ,id as id from Estate where city=?",ThreadSessionHelper.getCity());
		mv.jspData.put("houses", list);
		return mv;
	}
	
	@WebMethod
	public ModelAndView user(){
		ModelAndView mv = new ModelAndView();
		User u = ThreadSessionHelper.getUser();
		mv.jspData.put("user", u);
		List<Map> t1 = dao.listAsMap("select sum(yongjin) as allYongjin from HouseOrder where sellerId=? ", u.id);
		long buyerCount = dao.countHql("select count(*) from HouseOrder where sellerId=? ", u.id );
		mv.jspData.put("allYongjin", t1.get(0).get("allYongjin"));
		mv.jspData.put("buyerCount", buyerCount);
		Cookie tel = new Cookie("tel" , u.tel);
		tel.setMaxAge(3600*24*30);
		Cookie pwd = new Cookie("pwd" , u.pwd);
		pwd.setMaxAge(3600*24*30);
		ThreadSession.getHttpservletresponse().addCookie(tel);
		ThreadSession.getHttpservletresponse().addCookie(pwd);
		mv.jspData.put("title", "<span style='color: #ffffff; font-size: 1.3em;'>个人中心</span>");
		return mv;
	}
	
	@WebMethod
	public ModelAndView clients(){
		ModelAndView mv = new ModelAndView();
		User u = ThreadSessionHelper.getUser();
		mv.jspData.put("user", u);
		return mv;
	}
	
	@WebMethod
	public ModelAndView yongjin(){
		ModelAndView mv = new ModelAndView();
		User u = ThreadSessionHelper.getUser();
		List<Map> t1 = dao.listAsMap("select sum(yongjin) as allYongjin from HouseOrder where sellerId=? ", u.id);
		List<Map> t2 = dao.listAsMap("select sum(yongjin) as yongjin from HouseOrder where sellerId=? and status=?", u.id ,Constants.HouseOrderDeal);
		mv.jspData.put("allYongjin", t1.get(0).get("allYongjin"));
		mv.jspData.put("yongjin", t2.get(0).get("yongjin")==null? Float.valueOf(0) : t2.get(0).get("yongjin"));
		mv.jspData.put("title", "<span style='color: #ffffff; font-size: 1.3em;'>我的佣金</span>");
		return mv;
	}
	
	@WebMethod
	public ModelAndView listOrder(Page<Map> page , Integer sellerId){
		
		ModelAndView mv = new ModelAndView();
		StringBuilder hql = new StringBuilder("select  order.id as id, est.name as estateName, order.buyerName as buyerName ,order.buyerTel as buyerTel, order.yongjin  as  yongjin,"
				+ " order.sellerName as sellerName , order.addtime as addtime, order.status as status from HouseOrder order, "
				+ "Estate est where order.estateId=est.id and order.sellerId=?");
		List<Object> params = new ArrayList<Object>();
		params.add(sellerId);
		page.setPageSize(10);
		page = dao.findPage(page, hql.toString(), true,params.toArray());
		mv.data.put("page", JSONHelper.toJSON(page , DataHelper.dateSdf.toPattern()));
		return mv;
	}
	
	@WebMethod
	public ModelAndView ckyy(Page<Map> page , Integer orderId){
		ModelAndView mv = new ModelAndView();
		List<OrderGenJin> genjiList = dao.listByParams(OrderGenJin.class, "from OrderGenJin where orderId=? order by addtime desc", orderId);
		mv.jspData.put("genjiList", genjiList);
		HouseOrder order = dao.get(HouseOrder.class, orderId);
		mv.jspData.put("order" , order);
		Estate estate = dao.get(Estate.class, order.estateId);
		mv.jspData.put("estate", estate);
		return mv;
	}
	
	@WebMethod
	public ModelAndView rule(){
		ModelAndView mv = new ModelAndView();
		Article article = dao.getUniqueByKeyValue(Article.class, "name", "rule");
		mv.jspData.put("conts", article.conts);
		return mv;
	}
}
