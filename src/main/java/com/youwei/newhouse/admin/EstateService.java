package com.youwei.newhouse.admin;

import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

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
import com.youwei.newhouse.entity.Config;
import com.youwei.newhouse.entity.Estate;
import com.youwei.newhouse.entity.HouseImage;
import com.youwei.newhouse.util.ConfigHelper;
import com.youwei.newhouse.util.DataHelper;

@Module(name="/admin/estate")
public class EstateService {

	CommonDaoService dao = TransactionalServiceHelper.getTransactionalService(CommonDaoService.class);
	
	@WebMethod
	public ModelAndView list(){
		ModelAndView mv = new ModelAndView();
		return mv;
	}
	
	@WebMethod
	public ModelAndView add(){
		ModelAndView mv = new ModelAndView();
		mv = ConfigHelper.queryItems(mv);
		mv.jspData.put("estateUUID", UUID.randomUUID().toString());
		List<Config> list = dao.listByParams(Config.class, "from Config where type=?", "city");
		mv.jspData.put("citys", list);
		mv.jspData.put("me", ThreadSessionHelper.getUser());
		return mv;
	}
	
	@WebMethod
	public ModelAndView edit(Integer id){
		ModelAndView mv = new ModelAndView();
		Estate po = dao.get(Estate.class, id);
		mv = ConfigHelper.queryItems(mv);
		mv.jspData.put("estate", po);
		List<String> lxings = new ArrayList<String>();
		if(po.lxing!=null){
			for(String str : po.lxing.split(",")){
				lxings.add(str);
			}
		}
		mv.jspData.put("myLxings", lxings);
		mv.jspData.put("me", ThreadSessionHelper.getUser());
		return mv;
	}
	
	@WebMethod
	public ModelAndView view(Integer id){
		ModelAndView mv = new ModelAndView();
		Estate po = dao.get(Estate.class, id);
		mv = ConfigHelper.queryItems(mv);
		mv.jspData.put("estate", po);
		List<String> lxings = new ArrayList<String>();
		if(po.lxing!=null){
			for(String str : po.lxing.split(",")){
				lxings.add(str);
			}
		}
		mv.jspData.put("myLxings", lxings);
		mv.jspData.put("me", ThreadSessionHelper.getUser());
		return mv;
	}
	
	@WebMethod
	public ModelAndView update(Estate estate){
		ModelAndView mv = new ModelAndView();
		checkEstate(estate);
		Estate po = dao.get(Estate.class, estate.id);
		po.quyu = estate.quyu;
		po.name = estate.name;
		po.tel = estate.tel;
		po.junjia = estate.junjia;
		po.tejia = estate.tejia;
		po.opentime = estate.opentime;
		po.lxing = estate.lxing;
		po.wylx = estate.wylx;
		po.jjtc = estate.jjtc;
		po.zxiu = estate.zxiu;
		po.jzmj = estate.jzmj;
		po.rongji = estate.rongji;
		po.ghmj = estate.ghmj;
		po.lvhua = estate.lvhua;
		po.chewei = estate.chewei;
		po.hushu = estate.hushu;
		po.wyfee = estate.wyfee;
		po.tese = estate.tese;
		po.developer = estate.developer;
		po.wyComp = estate.wyComp;
		po.addr = estate.addr;
		po.yufu = estate.yufu;
		po.shidi = estate.shidi;
		po.tehui = estate.tehui;
		po.tuijian = estate.tuijian;
		po.jingdu = estate.jingdu;
		po.weidu = estate.weidu;
		po.youhuiEndtime = estate.youhuiEndtime;
		po.city = estate.city;
		po.province = estate.province;
		po.gongtan = estate.gongtan;
		po.chanquan = estate.chanquan;
		po.shouloubu = estate.shouloubu;
		po.xukezheng = estate.xukezheng;
		po.guishu = estate.guishu;
		po.daili = estate.daili;
		po.gongjijin = estate.gongjijin;
		po.fukuang = estate.fukuang;
		po.jiaofangDate = estate.jiaofangDate;
		po.mainHuxing = estate.mainHuxing;
		po.jieshao = estate.jieshao;
		po.manager = estate.manager;
		po.orderx = estate.orderx;
		po.youhuiPlan = estate.youhuiPlan;
		po.yongjin = estate.yongjin;
		dao.saveOrUpdate(po);
		return mv;
	}
	
	@WebMethod
	public ModelAndView delete(Integer id){
		ModelAndView mv = new ModelAndView();
		Estate po = dao.get(Estate.class, id);
		if(po!=null){
			dao.delete(po);
			//删除房源
			dao.execute("delete from House where estateId=?", id);
			//删除图片
			dao.execute("delete from HouseImage where estateUUID=?", po.uuid);
		}
		return mv;
	}
	
	@WebMethod
	public ModelAndView doSave(Estate estate){
		ModelAndView mv = new ModelAndView();
		checkEstate(estate);
		dao.saveOrUpdate(estate);
		return mv;
	}
	
	private void checkEstate(Estate estate){
		if(estate.tehui==1){
			if(estate.youhuiEndtime==null){
				throw new GException(PlatformExceptionType.BusinessException,"请先设置优惠结束时间");
			}
			if(estate.tejia==null){
				throw new GException(PlatformExceptionType.BusinessException,"请先设置特惠价格");
			}
		}
	}
	
	@WebMethod
	public ModelAndView listData(Page<Estate> page , String name , String city ,String quyu){
		ModelAndView mv = new ModelAndView();
		StringBuilder hql = new StringBuilder("from Estate where 1=1 ");
		List<String> params = new ArrayList<String>();
		if(StringUtils.isNotEmpty(name)){
			hql.append(" and name like ?");
			params.add("%"+name+"%");
		}
		if(StringUtils.isNotEmpty(quyu)){
			hql.append(" and quyu like ?");
			params.add("%"+quyu+"%");
		}
		if(StringUtils.isNotEmpty(city)){
			hql.append(" and city like ?");
			params.add("%"+city+"%");
		}
		hql.append(" order by orderx desc,id desc");
//		page.order = "desc";
//		page.orderBy="orderx";
		page = dao.findPage(page, hql.toString(), params.toArray());
		mv.data.put("page", JSONHelper.toJSON(page , DataHelper.dateSdf.toPattern()));
		return mv;
	}
	
	@WebMethod
	public ModelAndView listImage(String estateUUID , String imgType , String huxingUUID){
		ModelAndView mv = new ModelAndView();
		List<Object> params = new ArrayList<Object>();
		StringBuilder hql = new StringBuilder("from HouseImage where estateUUID=? and type=?");
		params.add(estateUUID);
		params.add(imgType);
		if(StringUtils.isNotEmpty(huxingUUID)){
			hql.append(" and huxingUUID=?");
			params.add(huxingUUID);
		}
		List<HouseImage> images = dao.listByParams(HouseImage.class, hql.toString(), params.toArray());
		mv.data.put("images", JSONHelper.toJSONArray(images));
		mv.data.put("imgType", imgType);
		return mv;
	}
	
	@WebMethod
	public ModelAndView deleteImage(Integer id){
		ModelAndView mv = new ModelAndView();
		HouseImage po = dao.get(HouseImage.class, id);
		if(po!=null){
			dao.delete(po);
		}
		return mv;
	}
}
