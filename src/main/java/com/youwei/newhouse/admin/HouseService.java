package com.youwei.newhouse.admin;

import java.util.ArrayList;
import java.util.List;

import org.apache.commons.lang.StringUtils;
import org.bc.sdak.CommonDaoService;
import org.bc.sdak.GException;
import org.bc.sdak.Page;
import org.bc.sdak.SimpDaoTool;
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

@Module(name="/admin/house")
public class HouseService {

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
		mv = ConfigHelper.queryItems(mv);
		List<HuXing> hxings = SimpDaoTool.getGlobalCommonDaoService().listByParams(HuXing.class, "from HuXing where estateId=?",estateId);
		mv.jspData.put("hxings", hxings);
		mv.jspData.put("estateId", estateId);
		return mv;
	}
	
	@WebMethod
	public ModelAndView edit(Integer id){
		ModelAndView mv = new ModelAndView();
		House po = dao.get(House.class, id);
		mv = ConfigHelper.queryItems(mv);
		List<HuXing> hxings = SimpDaoTool.getGlobalCommonDaoService().listByParams(HuXing.class, "from HuXing where estateId=?",po.estateId);
		mv.jspData.put("hxings", hxings);
		mv.jspData.put("house", po);
		return mv;
	}
	
	@WebMethod
	public ModelAndView update(House house){
		ModelAndView mv = new ModelAndView();
		check(house);
		House po = dao.get(House.class, house.id);
		house.estateId = po.estateId;
		house.hasSold = po.hasSold;
		dao.saveOrUpdate(house);
		return mv;
	}
	
	private void check(House house) {
		// TODO Auto-generated method stub
		
	}

	@WebMethod
	public ModelAndView delete(Integer id){
		ModelAndView mv = new ModelAndView();
		House po = dao.get(House.class, id);
		if(po!=null){
			dao.delete(po);
		}
		return mv;
	}
	
	@WebMethod
	public ModelAndView doSave(House house , Integer lcengStart , Integer lcengEnd ,String fanghao){
		ModelAndView mv = new ModelAndView();
		house.hasSold = 0;
		if(StringUtils.isEmpty(house.hxing)){
			throw new GException(PlatformExceptionType.BusinessException,"请先选择户型");
		}
		if(lcengEnd==null){
			//检查栋号，单元，房间号
			house.fhao = lcengStart+""+fanghao;
			House po = dao.getUniqueByParams(House.class, new String[]{"dhao" , "unit" , "fhao"}, new Object[]{house.dhao , house.unit , house.fhao});
			if(po!=null){
				throw new GException(PlatformExceptionType.BusinessException,"房源重复,请检查栋号，单元，房间号后提交");
			}
			dao.saveOrUpdate(house);
		}else{
			int count = 0;
			for(int i=lcengStart;i<=lcengEnd;i++){
				house.fhao = i+fanghao;
				//检查栋号，单元，房间号
				House po = dao.getUniqueByParams(House.class, new String[]{"dhao" , "unit" , "fhao"}, new Object[]{house.dhao , house.unit , house.fhao});
				if(po==null){
					house.id = null;
					dao.saveOrUpdate(house);
					count++;
				}
			}
			mv.data.put("result", "成功添加"+count+"套房源");
		}
		
		return mv;
	}
	
	@WebMethod
	public ModelAndView listData(Page<House> page , Integer estateId){
		ModelAndView mv = new ModelAndView();
		StringBuilder hql = new StringBuilder("from House where 1=1 ");
		List<Object> params = new ArrayList<Object>();
		if(estateId!=null){
			params.add(estateId);
			hql.append(" and estateId=?");
		}
		page = dao.findPage(page, hql.toString() , params.toArray());
		//找到户型图片
		for(House h : page.getResult()){
			HuXing hxing = dao.getUniqueByParams(HuXing.class, new String[]{"estateId" ,"name"},  new Object[]{estateId , h.hxing});
			if(hxing!=null){
				HouseImage img = dao.getUniqueByParams(HouseImage.class, new String[]{"huxingUUID" },  new Object[]{hxing.uuid});
				if(img!=null){
					h.hxingImg = img.path;
				}
			}
		}
		mv.data.put("page", JSONHelper.toJSON(page , DataHelper.dateSdf.toPattern()));
		return mv;
	}
}
