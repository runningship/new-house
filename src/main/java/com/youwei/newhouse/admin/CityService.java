package com.youwei.newhouse.admin;

import java.util.List;

import org.bc.sdak.CommonDaoService;
import org.bc.sdak.TransactionalServiceHelper;
import org.bc.sdak.utils.JSONHelper;
import org.bc.web.ModelAndView;
import org.bc.web.Module;
import org.bc.web.WebMethod;

import com.youwei.newhouse.entity.City;
import com.youwei.newhouse.entity.Config;

@Module(name="/admin/city")
public class CityService {
	CommonDaoService dao = TransactionalServiceHelper.getTransactionalService(CommonDaoService.class);
	
	@WebMethod
	public ModelAndView saveOrUpdate(City city){
		ModelAndView mv = new ModelAndView();
		City po = dao.getUniqueByParams(City.class, new String[]{"province" ,"name"},  new Object[]{city.province , city.name});
		if(po!=null){
			po.jingdu = city.jingdu;
			po.weidu = city.weidu;
			dao.saveOrUpdate(po);
		}else{
			dao.saveOrUpdate(city);
		}
		return mv;
	}
	
	@WebMethod
	public ModelAndView get(String province , String name){
		ModelAndView mv = new ModelAndView();
		City po = dao.getUniqueByParams(City.class, new String[]{"province" ,"name"},  new Object[]{province , name});
		if(po!=null){
			mv.data.put("city", JSONHelper.toJSON(po));
		}
		return mv;
	}
	
	@WebMethod
	public ModelAndView quyuAdd(){
		ModelAndView mv = new ModelAndView();
		List<Config> list = dao.listByParams(Config.class, "from Config where type=?", "city");
		mv.jspData.put("citys", list);
		return mv;
	}
}
