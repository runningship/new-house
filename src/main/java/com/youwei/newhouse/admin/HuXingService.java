package com.youwei.newhouse.admin;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import org.apache.commons.lang.StringUtils;
import org.bc.sdak.CommonDaoService;
import org.bc.sdak.GException;
import org.bc.sdak.Page;
import org.bc.sdak.Transactional;
import org.bc.sdak.TransactionalServiceHelper;
import org.bc.sdak.utils.JSONHelper;
import org.bc.web.ModelAndView;
import org.bc.web.Module;
import org.bc.web.PlatformExceptionType;
import org.bc.web.WebMethod;

import com.youwei.newhouse.entity.Estate;
import com.youwei.newhouse.entity.House;
import com.youwei.newhouse.entity.HouseImage;
import com.youwei.newhouse.entity.HuXing;
import com.youwei.newhouse.util.ConfigHelper;
import com.youwei.newhouse.util.DataHelper;

@Module(name="/admin/huxing")
public class HuXingService {

	CommonDaoService dao = TransactionalServiceHelper.getTransactionalService(CommonDaoService.class);
	
	@WebMethod
	public ModelAndView list(Integer estateId){
		ModelAndView mv = new ModelAndView();
		mv.jspData.put("estateId", estateId);
		return mv;
	}
	
	@WebMethod
	public ModelAndView add(Integer estateId){
		ModelAndView mv = new ModelAndView();
		Estate estate = dao.get(Estate.class, estateId);
		mv.jspData.put("estate", estate);
		mv.jspData.put("huxingUUID", UUID.randomUUID().toString());
		return mv;
	}
	
	@WebMethod
	public ModelAndView edit(Integer id){
		ModelAndView mv = new ModelAndView();
		HuXing po = dao.get(HuXing.class, id);
		Estate estate = dao.get(Estate.class, po.estateId);
//		mv = ConfigHelper.queryItems(mv);
		mv.jspData.put("huxing", po);
		mv.jspData.put("estate", estate);
//		mv.jspData.put("images", images);
		return mv;
	}
	
	@WebMethod
	@Transactional
	public ModelAndView delete(Integer id){
		ModelAndView mv = new ModelAndView();
		HuXing po = dao.get(HuXing.class, id);
		if(po!=null){
			dao.delete(po);
			//删除户型图片
			dao.execute("delete from HouseImage where huxingUUID=?", po.uuid);
		}
		return mv;
	}
	
	@WebMethod
	public ModelAndView update(HuXing huxing){
		ModelAndView mv = new ModelAndView();
		HuXing po = dao.getUniqueByParams(HuXing.class, new String[]{"estateId" , "name"}, new Object[]{huxing.estateId , huxing.name});
		if(po!=null){
			throw new GException(PlatformExceptionType.BusinessException,"重复的户型，请修改后提交");
		}
		po = dao.get(HuXing.class, huxing.id);
		if(po!=null){
			po.name = huxing.name;
			po.conts = huxing.conts;
			dao.saveOrUpdate(po);
		}
		
		return mv;
	}
	
	@WebMethod
	public ModelAndView doSave(HuXing huxing){
		ModelAndView mv = new ModelAndView();
		HuXing po = dao.getUniqueByParams(HuXing.class, new String[]{"estateId" , "name"}, new Object[]{huxing.estateId , huxing.name});
		if(po!=null){
			throw new GException(PlatformExceptionType.BusinessException,"重复的户型，请修改后提交");
		}
		dao.saveOrUpdate(huxing);
		return mv;
	}
	
	@WebMethod
	public ModelAndView listData(Page<Map> page , Integer estateId){
		ModelAndView mv = new ModelAndView();
		StringBuilder hql = new StringBuilder("select hx.id as id, hx.name as name , est.name as estateName from HuXing hx, Estate est where est.id=hx.estateId ");
		List<Object> params = new ArrayList<Object>();
		if(estateId!=null){
			params.add(estateId);
			hql.append(" and hx.estateId=?");
		}
		page = dao.findPage(page, hql.toString(), true , params.toArray());
		mv.data.put("page", JSONHelper.toJSON(page , DataHelper.dateSdf.toPattern()));
		return mv;
	}
}
