package com.youwei.newhouse;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang.StringUtils;
import org.bc.sdak.CommonDaoService;
import org.bc.sdak.Page;
import org.bc.sdak.TransactionalServiceHelper;
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

@Module(name="/")
public class PageService {

	CommonDaoService dao = TransactionalServiceHelper.getTransactionalService(CommonDaoService.class);
	
	@WebMethod
	public ModelAndView index(Page<Map> page){
		ModelAndView mv = new ModelAndView();
		String userAgent=ThreadSession.HttpServletRequest.get().getHeader("user-agent");
		if(userAgent.contains("Linux") || userAgent.contains("Android") || userAgent.contains("iPhone")){
			mv.redirect="m/index.jsp";
			return mv;
		}
		mv = tehui(mv);
		page.setPageSize(9);
		page.order = "desc";
		page.orderBy = "orderx";
		page = dao.findPage(page, "select est.id as id, est.name as name , est.quyu as quyu ,est.junjia as junjia , est.tejia as tejia, est.youhuiPlan as youhuiPlan, "
				+ "img.path as img , est.yufu as yufu , est.shidi as shidi from Estate est,HouseImage img"
				+ " where est.uuid=img.estateUUID and est.tuijian=1 and est.city=? and img.type='main'", true,new Object[]{ThreadSessionHelper.getCity()});
		mv.jspData.put("page", page);
		mv.jspData.put("currNav", "index");
		long total = dao.countHql("select count(*) from Estate where city=?",ThreadSessionHelper.getCity() );
		mv.jspData.put("total", total);
		mv.jspData.put("page", page);
		//最大优惠
		Page<Map> page2 = new Page<Map>();
		page2.setPageSize(1);
		page2 = dao.findPage(page2, "select (h.shidi-h.yufu) as youhui from Estate est, House h where h.estateId=est.id and est.city=? order by youhui desc", true , new Object[]{ThreadSessionHelper.getCity()});
		if(!page2.getResult().isEmpty()){
			mv.jspData.put("maxYouhui", page2.getResult().get(0).get("youhui"));
		}
		return mv;
	}
	
	private ModelAndView tehui(ModelAndView mv){
		//限时特惠
		Page<Map> page = new Page<Map>();
		page.setPageSize(5);
		page = dao.findPage(page, "select est.id as id, est.name as name , est.quyu as quyu ,est.tejia as tejia , est.junjia as junjia , est.youhuiPlan as youhuiPlan,"
				+ " est.opentime as opendate, est.youhuiEndtime as youhuiEndtime, img.path as img from Estate est,"
				+ "HouseImage img where est.uuid=img.estateUUID and est.tehui=1 and est.city=? and img.type='main'", true,new Object[]{ThreadSessionHelper.getCity()});
		mv.jspData.put("youhuiList", page.getResult());
		return mv;
	}
	
	@WebMethod
	public ModelAndView sale(Page<Map> page){
		ModelAndView mv = new ModelAndView();
		mv = ConfigHelper.queryItems(mv);
		mv = tehui(mv);
		mv.jspData.put("currNav", "sale");
		page.setPageSize(5);
		page.order="desc";
		page.orderBy="orderx";
		page = dao.findPage(page, "select est.id as id, est.name as name , est.quyu as quyu ,est.tejia as tejia , est.junjia as junjia , est.youhuiPlan as youhuiPlan,"
				+ " est.opentime as opendate, est.youhuiEndtime as youhuiEndtime, img.path as img , est.yufu as yufu, est.shidi as shidi from Estate est,"
				+ "HouseImage img where est.uuid=img.estateUUID and est.tehui=1 and est.city=? and img.type='main'", true,new Object[]{ThreadSessionHelper.getCity()});
		mv.jspData.put("page", page);
//		//已经成交
//		long dealCount = dao.countHql("select count(*) from House house, Estate est where house.estateId=est.id and est.tehui=1 and house.hasSold=1");
//		mv.jspData.put("dealCount", dealCount);
		
		for(Map map : page.getResult()){
			//与约数量
			long count = dao.countHql("select count(*) from HouseOrder where estateId=?", map.get("id"));
			map.put("orderCount", count);
		}
		
		return mv;
	}
	
	
	@WebMethod
	public ModelAndView setCity(String province , String city){
		ModelAndView mv = new ModelAndView();
		if("null".equals(city)){
			return mv;
		}
		
		ThreadSession.getHttpSession().setAttribute(Constants.Session_Attr_City, city);
		ThreadSession.getHttpSession().setAttribute(Constants.Session_Attr_Province, province);
		return  mv;
	}
	
	@WebMethod
	public ModelAndView houses(Page<Map> page , EstateQuery query){
		ModelAndView mv = new ModelAndView();
		mv = ConfigHelper.queryItems(mv);
		mv = tehui(mv);
		mv.jspData.put("selectedQuyu", query.quyu);
		mv.jspData.put("selectedLxing",query.lxing);
		mv.jspData.put("searchText", query.searchText);
		mv.jspData.put("jiageStart", query.jiageStart);
		mv.jspData.put("jiageEnd", query.jiageEnd);
		mv.jspData.put("currNav", "houses");
		List<Object> params = new ArrayList<Object>();
		params.add(ThreadSessionHelper.getCity());
		page.setPageSize(12);
		StringBuilder hql = new StringBuilder("select est.id as id, est.name as name , est.quyu as quyu ,est.tejia as tejia , est.junjia as junjia , est.yufu as yufu , est.shidi as shidi, est.youhuiPlan as youhuiPlan, "
				+ "  est.opentime as opendate, est.youhuiEndtime as youhuiEndtime, img.path as img from Estate est,"
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
		mv.jspData.put("page", page);
		return mv;
	}
	
	@WebMethod
	public ModelAndView sellerIndex(){
		ModelAndView mv = new ModelAndView();
		User seller = ThreadSessionHelper.getUser();
		mv.jspData.put("seller", seller);
		
		HouseImage img = dao.getUniqueByParams(HouseImage.class, new String[]{"estateUUID" , "type"}, new Object[]{seller.id.toString() , "touxiang"});
		mv.jspData.put("touxiang", img==null ? "" : img.path);
		return mv;
	}
	
	@WebMethod
	public ModelAndView houseMap(){
		ModelAndView mv = new ModelAndView();
		List<Map> list = dao.listAsMap("select name as name, jingdu as jingdu , weidu as weidu ,id as id from Estate where city=?",ThreadSessionHelper.getCity());
		mv.jspData.put("houses", list);
		mv.jspData.put("currNav", "map");
		return mv;
	}
	
	@WebMethod
	public ModelAndView info(Integer estateId){
		ModelAndView mv = new ModelAndView();
		Estate po = dao.get(Estate.class, estateId);
		mv.jspData.put("estate", po);
		//户型图
		List<HouseImage> images = dao.listByParams(HouseImage.class, "from HouseImage where estateUUID=?", po.uuid);
		for(HouseImage img : images){
			if(Constants.HuXing.equals(img.type)){
				mv.jspData.put("huxing_img", img.path);
			}else if(Constants.XiaoGuo.equals(img.type)){
				mv.jspData.put("xiaoguo_img", img.path);
			}else if(Constants.ShiJing.equals(img.type)){
				mv.jspData.put("shijing_img", img.path);
			}else if(Constants.GuiHua.equals(img.type)){
				mv.jspData.put("guihua_img", img.path);
			}else if(Constants.Main.equals(img.type)){
				mv.jspData.put("main_img", img.path);
			}
		}
		Page<Map> page = new Page<Map>();
		page.setPageSize(1);
		page = dao.findPage(page, "select totalPrice as totalPrice from House where estateId=? order by totalPrice desc", true, new Object[]{estateId});
		if(!page.getResult().isEmpty()){
			mv.jspData.put("minTotalPrice", page.getResult().get(0).get("totalPrice"));
		}
		return mv;
	}
	
	@WebMethod
	public ModelAndView buyer(Page<Map> page , String type){
		ModelAndView mv = new ModelAndView();
		mv.jspData.put("type", type);
		return mv;
	}
	
	@WebMethod
	public ModelAndView picList(Integer estateId){
		ModelAndView mv = new ModelAndView();
		Estate estate = dao.get(Estate.class, estateId);
		List<Map> fenleiList = dao.listAsMap("select type as name ,count(*) as total from HouseImage where estateUUID=? group by type", estate.uuid);
		int all = 0;
		for(Map map : fenleiList){
			Long total = (Long)map.get("total");
			all+=total;
		}
		List<HouseImage> images = dao.listByParams(HouseImage.class, "from HouseImage where estateUUID=?",  estate.uuid);
		mv.jspData.put("estate", estate);
		mv.jspData.put("fenleiList", fenleiList);
		mv.jspData.put("images", images);
		mv.jspData.put("all", all);
		return mv;
	}
	@WebMethod
	public ModelAndView logout(){
		ModelAndView mv = new ModelAndView();
		ThreadSession.getHttpSession().removeAttribute("user");
		mv.redirect="./index.jsp";
		return mv;
	}
	
	@WebMethod
	public ModelAndView about(){
		ModelAndView mv = new ModelAndView();
		Article article = dao.getUniqueByKeyValue(Article.class, "name", "about");
		mv.jspData.put("conts", article.conts);
		return mv;
	}
	
	@WebMethod
	public ModelAndView contactUs(){
		ModelAndView mv = new ModelAndView();
		Article article = dao.getUniqueByKeyValue(Article.class, "name", "contactUs");
		mv.jspData.put("conts", article.conts);
		return mv;
	}
	
	@WebMethod
	public ModelAndView shenming(){
		ModelAndView mv = new ModelAndView();
		Article article = dao.getUniqueByKeyValue(Article.class, "name", "shenming");
		mv.jspData.put("conts", article.conts);
		return mv;
	}
	
	@WebMethod
	public ModelAndView registe(){
		ModelAndView mv = new ModelAndView();
		Article article = dao.getUniqueByKeyValue(Article.class, "name", "registe");
		mv.jspData.put("conts", article.conts);
		return mv;
	}
	
	@WebMethod
	public ModelAndView secondHand(){
		ModelAndView mv = new ModelAndView();
		Article article = dao.getUniqueByKeyValue(Article.class, "name", "secondHand");
		mv.jspData.put("conts", article.conts);
		return mv;
	}
	
	@WebMethod
	public ModelAndView yongjin(){
		ModelAndView mv = new ModelAndView();
		Article article = dao.getUniqueByKeyValue(Article.class, "name", "yongjin");
		mv.jspData.put("conts", article.conts);
		return mv;
	}
}
