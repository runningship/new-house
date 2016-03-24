package com.youwei.newhouse.admin;

import java.io.File;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import org.apache.commons.io.FileUtils;
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

import com.youwei.newhouse.Constants;
import com.youwei.newhouse.FileUploadServlet;
import com.youwei.newhouse.ThreadSessionHelper;
import com.youwei.newhouse.entity.Config;
import com.youwei.newhouse.entity.Estate;
import com.youwei.newhouse.entity.HouseImage;
import com.youwei.newhouse.entity.User;
import com.youwei.newhouse.util.ConfigHelper;
import com.youwei.newhouse.util.DataHelper;

@Module(name="/admin/estate")
public class EstateService {

	CommonDaoService dao = TransactionalServiceHelper.getTransactionalService(CommonDaoService.class);
	
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
		User charger = dao.get(User.class, po.managerUid);
		if(charger!=null){
			mv.jspData.put("managerUid", charger.id);
			mv.jspData.put("manager", charger.name+" "+charger.tel);
		}
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
		Estate po = dao.get(Estate.class, estate.id);
		po.quyu = estate.quyu;
		po.name = estate.name;
		po.tel = estate.tel;
		po.junjia = estate.junjia;
		po.opentime = estate.opentime;
		po.lxing = estate.lxing;
		po.wylx = estate.wylx;
		po.zxiu = estate.zxiu;
		po.lvhua = estate.lvhua;
		po.wyfee = estate.wyfee;
		po.tese = estate.tese;
		po.developer = estate.developer;
		po.addr = estate.addr;
		po.tuijian = estate.tuijian;
		po.city = estate.city;
		po.province = estate.province;
		po.gongtan = estate.gongtan;
		po.guishu = estate.guishu;
		po.jiaofangDate = estate.jiaofangDate;
		po.mainHuxing = estate.mainHuxing;
		po.orderx = estate.orderx;
		po.shenghuo = estate.shenghuo;
		po.xuequ = estate.xuequ;
		po.jiaotong = estate.jiaotong;
		po.yongjin = estate.yongjin;
		if(estate.status!=null){
			po.status = estate.status;
		}
		po.daikanRule = estate.daikanRule;
		dao.saveOrUpdate(po);
		return mv;
	}
	
	@WebMethod
	public ModelAndView delete(Integer id){
		ModelAndView mv = new ModelAndView();
		Estate po = dao.get(Estate.class, id);
		if(po!=null){
			dao.delete(po);
			//删除图片
			dao.execute("delete from HouseImage where estateUUID=?", po.uuid);
		}
		return mv;
	}
	
	@WebMethod
	public ModelAndView doSave(Estate estate){
		ModelAndView mv = new ModelAndView();
		estate.status=0;
		dao.saveOrUpdate(estate);
		return mv;
	}
	
	@WebMethod
	public ModelAndView listData(Page<Estate> page , String name , String city ,String quyu , Integer managerUid){
		ModelAndView mv = new ModelAndView();
		StringBuilder hql = new StringBuilder("from Estate est where 1=1 ");
		List<Object> params = new ArrayList<Object>();
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
		if(managerUid!=null){
			hql.append(" and managerUid = ?");
			params.add(managerUid);
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
			//删除图片
			String orignal = FileUploadServlet.BaseFileDir+File.separator+po.estateUUID+File.separator+po.path;
			String compressPath = orignal+".x.jpg";
			String thumbPath = orignal+".t.jpg";
			FileUtils.deleteQuietly(new File(compressPath));
			FileUtils.deleteQuietly(new File(thumbPath));
		}
		return mv;
	}
}
