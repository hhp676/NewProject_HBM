package com.hginfo.hbm.base.page;

import java.util.List;

import com.alibaba.fastjson.JSONObject;
import com.hginfo.hbm.base.meta.FieldMeta;
import com.hginfo.hbm.base.meta.TableMeta;
import com.hginfo.hutils.StringUtil;

/**
 * easyui表头过滤条件解析器。<br />
 * Created by qiujingde on 2016/12/19.
 * @author qiujingde
 */
final class FilterRuleParser {

    /**
     * 私有构造方法，防止FilterRuleParser被实例化。
     */
    private FilterRuleParser() { }

    /**
     * 转换为sql条件。
     * @param filterRules easyUI表头过滤json串
     * @param meta entity表元数据
     * @return 对应的sql条件
     */
    static String parse(String filterRules, TableMeta meta) {
        if (StringUtil.isBlank(filterRules)) {
            return null;
        }

        List<FilterRule> rules = JSONObject.parseArray(filterRules, FilterRule.class);

        StringBuilder sb = new StringBuilder();
        rules.stream().filter(rule -> {
            FieldMeta field = meta.getDbField(rule.getField());
            return field != null;
        }).forEach(rule -> {
            FieldMeta field = meta.getDbField(rule.getField());
            sb.append("AND ").append(field.getTableAlias()).append(".").append(field.getDbFieldName());
            boolean isStringField = String.class.isAssignableFrom(field.getFieldType());
            sb.append(FilterOpParser.getFilterOpSql(rule.getOp(), StringUtil.trim(rule.getValue()), isStringField));
        });

        return sb.toString();
    }

}
