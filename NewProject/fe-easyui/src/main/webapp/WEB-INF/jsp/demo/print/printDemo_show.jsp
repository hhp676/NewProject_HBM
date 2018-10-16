<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<%@ include file="/WEB-INF/jsp/common/meta.jsp"%>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>打印demo</title>
</head>
<body>
	<div class="easyui-layout" fit="true">
		<div data-options="region:'center',title:'打印demo',border:true" style="padding: 0px;">
			<div id="area1" style="width: 30%; float: left;">
			    <fieldset>
			        <legend>Print Area 1</legend>
					<span style="color: #000777;">print me</span> <span class="test">xyz</span>
					<input name="chkTest1" value="1" type="checkbox">
					<input name="chkTest2" value="2" type="checkbox">
					<input value="3" name="rdoTest3" type="radio"> 
					<input value="4" name="rdoTest3" type="radio"> <br> 
					<input value="" name="textTest5" type="text"> <br> 
					<select name="selTest6">
						<option value="A">A</option>
						<option value="B">B</option>
						<option value="C">C</option>
					</select> 
					<textarea name="textareaTest8"></textarea>
					<br> <img src="${ctx}/static/custom/img/logo2.png" >
				</fieldset>
			</div>
			<div>
                <a class="easyui-linkbutton" iconCls="icon_auto_colorful__print"  
                     onclick="printDemo.printAll();">网页打印</a>
                <a class="easyui-linkbutton" iconCls="icon_auto_colorful__print"  
                     onclick="printDemo.printTest();">局部打印</a>
            </div>
		</div>
	</div>
	<script type="text/javascript">
	var printDemo = {};
	printDemo.printAll = function(){
		window.print();
	}
	printDemo.printTest = function(){
    	//mode:popup弹窗执行打印/popClose打印执行完毕自动关闭/extraHead头信息
    	var options = { mode : 'popup', popClose : 'popup',
                extraHead : '<meta charset="utf-8" />,<meta http-equiv="X-UA-Compatible" content="IE=edge"/>' };
       //选择器可以书写多个,以英文逗号间隔,如:#area1,#area2也可以书写样式选择器
       $( "#area1" ).printArea( options );
    }
    </script>
</body>
</html>