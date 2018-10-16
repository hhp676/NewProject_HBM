<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<%@ include file="/WEB-INF/jsp/common/meta.jsp"%>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>员工分布统计</title>
</head>
<body>
    <div class="easyui-layout" style="height: 500px;">
        <div data-options="region:'center',border:false" style="padding: 0px; ">
            <div id="sysEmployeeOrgReport" style="height:450px;margin-top: 50px;width: 49%;float: left;"></div>
            <div style="height:450px;margin-top: 50px;width: 49%;float: right;">
                <fieldset style="height: 100%">
                    <legend>预留区域(功能待完善)</legend>
                </fieldset>
            </div>
        </div>
    </div>
    <script type="text/javascript">
    //图表  
    var sysEmployeeOrgReport = echarts.init($('#sysEmployeeOrgReport').get(0));  
  
    //查询  
    function loadSysEmployeeOrgReport(code) { 
        //清空echart
        sysEmployeeOrgReport.clear();  
        sysEmployeeOrgReport.showLoading({text: '读取数据中...'});
        HgUtil.post("/sys/report/sysEmployeeOrgReport/getOrgUserPieData", {orgCode:code}, function (data) {  
        	sysEmployeeOrgReport.hideLoading();  
            if (data.success) {
                //设置echart数据
                sysEmployeeOrgReport.setOption(data.data);  
            } else {
                HgUi.error("操作失败,请稍后再试!", function(){});
            }  
        });  
    } 
    //绑定双击事件
    sysEmployeeOrgReport.on('dblclick', function (param) {
    	var name=param.name;
    	if(name.substr(name.length-2,name.length)=='直属'){
    		HgUi.error('部门直属不存在需要展示的下级!',function(){});
    	}else{
    		var strs = name.split("(");
    		var code = strs[strs.length-1];
    		code = code.substr(0,code.length-1);
    		loadSysEmployeeOrgReport(code);
    	}
    });
    //载入图表  
    loadSysEmployeeOrgReport(null);  
    </script>
</body>
</html>