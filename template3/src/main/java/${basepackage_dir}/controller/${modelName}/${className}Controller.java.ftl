<#assign className = table.className>   
<#assign classNameLower = className?uncap_first> 
package ${basepackage}.controller.{modelName};

import ${basepackage}.model.${modelName}.${className};
import ${basepackage}.model.${modelName}.${className}Example;
import ${basepackage}.service.${modelName}.${className}Service;


import java.util.Date;
import java.util.Map;
import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

/**
 *${table.remarks}管理
 */
@Controller
@RequestMapping(value = "${classNameLower}Controller")
public class ${className}Controller extends BaseController{
	
	private Logger logger = LoggerFactory.getLogger(getClass());
	
	@Autowired
	private ${className}Service ${classNameLower}Service;
	
	@RequestMapping(value = "go${className}")
    public String go${className}() {
        logger.info("【${table.remarks}管理Controller】");
        return "${modelName}/${className}";
    }

    /**
     * 按分页查询方言信息
     *
     * @param pageNum
     * @param pageSize
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "${className}Search")
    public Map<String, Object> get${className}List(
            HttpServletRequest request,
            @ModelAttribute ${className}  ${classNameLower}
            @RequestParam(value = "pagenum", defaultValue = "1") final int pageNum,
            @RequestParam(value = "pagesize", defaultValue = "20") final int pageSize
    ) {
        String logTxt = "【${table.remarks}分页查询】";
        String beginTime = request.getParameter("beginTime");
        String endTime = request.getParameter("endTime");

        String sortdatafield = request.getParameter("sortdatafield");//排序列
        String sortorder = request.getParameter("sortorder");//排序方式

        logger.info(logTxt + "pageNum = " + pageNum);
        logger.info(logTxt + "pageSize = " + pageSize);
        logger.info(logTxt + "beginTime = " + beginTime);
        logger.info(logTxt + "endTime = " + endTime);

        Page<${className}> page = new Page<>(pageNum + 1, pageSize);
        ${className}Example example = new ${className}Example();
        ${className}Example.Criteria criteria = example.createCriteria();
        example.createCriteria().andIdIsNotNull();

        //FIXME: 按需添加查询条件
        /**
        if (StringUtil.isNotEmpty(dialectname)) {
            criteria.andDialectnameLike("%" + dialectname + "%");
        }
        if (StringUtil.isNotEmpty(beginTime)) {
            criteria.andModiflytimeGreaterThanOrEqualTo(DateFormatUtil.stringToDate(beginTime, "yyyy-MM-dd"));
        }
        if (StringUtil.isNotEmpty(endTime)) {
            criteria.andModiflytimeLessThanOrEqualTo(DateFormatUtil.stringToDate(endTime + " 23:59:59", "yyyy-MM-dd HH:mm:ss"));
        }
        if (StringUtil.isNotEmpty(sortdatafield)) {
            example.setOrderByClause(sortdatafield + " " + sortorder);
        } else {
            example.setOrderByClause("id asc");

        }
        
        */
        
        List<${className}> enginfos = ${classNameLower}Service.selectByExample(page, example);
        Map<String, Object> engMap = new HashMap<>();
        engMap.put("page", page);
        engMap.put("content", enginfos);
        return engMap;
    }

    @ResponseBody
    @RequestMapping(value = "save", method = RequestMethod.POST)
    private ResultJson saveLan(HttpSession session, @ModelAttribute ${className}  ${classNameLower}) {
   
        logger.info("【${table.remarks}】【对象信息: " +${classNameLower} + "】");

        ${className}Example example = new ${className}Example();
        //FIXME:添加查询条件
        example.createCriteria();
        
        List<${className}> enginfos = ${classNameLower}Service.selectByExample(example);
        if (enginfos.isEmpty()) {
            User user = (User) session.getAttribute("userInfo");//获取用户信息
            
            ${classNameLower}.setCreatorid(user.getId());
            ${classNameLower}.setCreatetime(new Date());
            ${classNameLower}.setModiflytime(new Date());
            
            ${classNameLower}Service.insertSelective(dialectInfo);
            logger.info("【${table.remarks}添加方法】添加成功");
            return ResultJson.success();
        }
        logger.info("【${table.remarks}添加方法】添加失败");
        return ResultJson.failure();
    }

    @ResponseBody
    @RequestMapping(value = "update", method = RequestMethod.POST)
    private ResultJson update(HttpSession session,"${table.idColumn.columnNameFirstLower}") ${table.idColumn.javaType} ${table.idColumn.columnNameFirstLower} , @ModelAttribute ${className}  ${classNameLower} ) {
        logger.info("【${table.remarks}修改方法】 【id = " + ${table.idColumn.columnNameFirstLower}  + "】");
        
        User user = (User) session.getAttribute("userInfo");//获取用户信息
        
        ${classNameLower}.setModiflytime(new Date());
       ${classNameLower}.setModifyid(new Date());
        
        ${classNameLower}Service.updateByPrimaryKeySelective({classNameLower});
        return ResultJson.success();
    }

    @ResponseBody
    @RequestMapping(value = "delete", method = RequestMethod.POST)
    private ResultJson delete(@RequestParam(value = "id") final String idstr) {
        logger.info("【${table.remarks}删除方法】方言【ids = " + idstr + "】");

        String[] ids = idstr.split(",");
        for (String id : ids) {
            ${classNameLower}Service.deleteByPrimaryKey(Long.valueOf(id));
        }
        logger.info("【${table.remarks}删除方法】共删除类【" + ids.length + "】条数据");
        return ResultJson.success();
    }
}

