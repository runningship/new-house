package com.youwei.newhouse.util;

import java.util.List;

import org.bc.sdak.SimpDaoTool;
import org.bc.web.ModelAndView;

import com.youwei.newhouse.ThreadSessionHelper;
import com.youwei.newhouse.entity.Config;

public class ConfigHelper {

	public static ModelAndView queryItems(ModelAndView mv){
		//查询条件
		List<Config> quyus = SimpDaoTool.getGlobalCommonDaoService().listByParams(Config.class, "from Config where type=? and attr=?","quyu" , ThreadSessionHelper.getCity());
		
		List<Config> lxings = SimpDaoTool.getGlobalCommonDaoService().listByParams(Config.class, "from Config where type=?","lxing");
		List<Config> zxius = SimpDaoTool.getGlobalCommonDaoService().listByParams(Config.class, "from Config where type=?","zxiu");
		List<Config> wylxs = SimpDaoTool.getGlobalCommonDaoService().listByParams(Config.class, "from Config where type=?","wylx");
		mv.jspData.put("quyus", quyus);
		mv.jspData.put("lxings", lxings);
		mv.jspData.put("zxius", zxius);
		mv.jspData.put("wylxs", wylxs);
		return  mv;
	}
}
