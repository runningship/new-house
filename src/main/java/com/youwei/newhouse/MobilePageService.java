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
	public ModelAndView listSalesData(Page<Map> page , String quyu){
		ModelAndView mv = new ModelAndView();
		StringBuilder hql = new StringBuilder("select est.id as id, est.uuid as uuid, est.name as name , est.quyu as quyu ,est.junjia as junjia , est.yongjin as yongjin,"
				+ " est.opentime as opendate, est.addr as addr , img.path as img , est.wylx as wylx , est.mainHuxing as mainHuxing from Estate est,"
				+ "HouseImage img where est.uuid=img.estateUUID and img.type='main'");
//		List<String> params = new ArrayList<String>();
//		params.add(ThreadSessionHelper.getCity());
//		if(StringUtils.isNotEmpty(quyu)){
//			hql.append(" and est.quyu=? ");
//			params.add(quyu);
//		}
		page.setPageSize(50);
		page.order="desc";
		page.orderBy = "est.orderx";
		page = dao.findPage(page, hql.toString(), true,new Object[]{});
		mv.data.put("page", JSONHelper.toJSON(page , DataHelper.dateSdf.toPattern()));
		
		StringBuilder hql2 = new StringBuilder("select est.id as id, est.uuid as uuid, est.name as name , est.quyu as quyu ,est.junjia as junjia , est.yongjin as yongjin,"
				+ " img.path as img from Estate est,"
				+ "HouseImage img where est.uuid=img.estateUUID and img.type='tuijian' and est.tuijian=1");
		List<Map> tuijianList = dao.listAsMap(hql2.toString() , new Object[]{});
		mv.data.put("tuijianList", tuijianList);
		return mv;
	}
	
	@WebMethod
	public ModelAndView info(Integer estateId){
		ModelAndView mv = new ModelAndView();
		Estate po = dao.get(Estate.class, estateId);
		mv.data.put("estate", JSONHelper.toJSON(po));
		
		//户型图
		List<HouseImage> hxImgList = dao.listByParams(HouseImage.class, "from HouseImage where estateUUID=? and type=? ", po.uuid , Constants.HuXing);
		List<HouseImage> xgImgList = dao.listByParams(HouseImage.class, "from HouseImage where estateUUID=? and type=? ", po.uuid , Constants.XiaoGuo);
		mv.data.put("hxImgList", JSONHelper.toJSONArray(hxImgList));
		mv.data.put("xgImgList", JSONHelper.toJSONArray(xgImgList));
		return mv;
	}
	
	@WebMethod
	public ModelAndView listOrderGenjin(Integer orderId){
		ModelAndView mv = new ModelAndView();
		HouseOrder order = dao.get(HouseOrder.class, orderId);
		mv.data.put("order", JSONHelper.toJSON(order));
		List<OrderGenJin> genjiList = dao.listByParams(OrderGenJin.class, "from OrderGenJin where orderId=?", orderId);
		mv.data.put("genjiList", JSONHelper.toJSONArray(genjiList));
		return mv;
	}
	
}
