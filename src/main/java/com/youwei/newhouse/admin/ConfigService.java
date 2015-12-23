package com.youwei.newhouse.admin;

import java.util.ArrayList;
import java.util.List;

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

import com.youwei.newhouse.entity.Config;
import com.youwei.newhouse.util.DataHelper;

@Module(name="/admin/config")
public class ConfigService {
	CommonDaoService dao = TransactionalServiceHelper.getTransactionalService(CommonDaoService.class);
	
	@WebMethod
	public ModelAndView listData(Page<Config> page , String type){
		ModelAndView mv = new ModelAndView();
		StringBuilder hql = new StringBuilder("from Config where 1=1 ");
		List<String> params = new ArrayList<String>();
		if(StringUtils.isNotEmpty(type)){
			hql.append(" and type=?");
			params.add(type);
		}
		page = dao.findPage(page, hql.toString(), params.toArray());
		mv.data.put("page", JSONHelper.toJSON(page , DataHelper.dateSdf.toPattern()));
		return mv;
	}
	
	
	@WebMethod
	public ModelAndView doSave(Config conf){
		ModelAndView mv = new ModelAndView();
		if(StringUtils.isEmpty(conf.attr)){
			conf.attr = conf.value;
		}
		if(StringUtils.isEmpty(conf.type) ){
			throw new GException(PlatformExceptionType.BusinessException,"配置项类别或名称不能为空。");
		}
		Config po = dao.getUniqueByParams(Config.class, new String[]{"type" , "attr" , "value"}, new Object[]{conf.type, conf.attr  , conf.value});
		if(po!=null){
			throw new GException(PlatformExceptionType.BusinessException,"存在相同的配置项。");
		}
		dao.saveOrUpdate(conf);
		return mv;
	}
	
	@WebMethod
	public ModelAndView delete(Integer id){
		ModelAndView mv = new ModelAndView();
		Config po = dao.get(Config.class, id);
		dao.delete(po);
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
