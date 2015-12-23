package com.youwei.newhouse.admin;

import org.bc.sdak.CommonDaoService;
import org.bc.sdak.TransactionalServiceHelper;
import org.bc.web.ModelAndView;
import org.bc.web.Module;
import org.bc.web.WebMethod;

import com.youwei.newhouse.entity.Article;

@Module(name="/admin/article")
public class ArticleService {
	CommonDaoService dao = TransactionalServiceHelper.getTransactionalService(CommonDaoService.class);
	
	@WebMethod
	public ModelAndView update(String pageName , String conts){
		ModelAndView mv = new ModelAndView();
		Article article = dao.getUniqueByKeyValue(Article.class, "name", pageName);
		article.conts = conts;
		dao.saveOrUpdate(article);
		return mv;
	}
	
	@WebMethod
	public ModelAndView edit(String pageName){
		ModelAndView mv = new ModelAndView();
		Article article = dao.getUniqueByKeyValue(Article.class, "name", pageName);
		mv.jspData.put("conts", article.conts);
		mv.jspData.put("pageName", pageName);
		return mv;
	}
}
