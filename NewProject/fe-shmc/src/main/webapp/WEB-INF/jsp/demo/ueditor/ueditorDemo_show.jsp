<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <%@ include file="/WEB-INF/jsp/common/meta.jsp"%>
    <meta http-equiv="Content-Type" content="text/html;charset=utf-8"/>
    <title>demo</title>
</head>
<body>
    <div class="easyui-layout" style="height: 900px">
        <div data-options="region:'center',border:false,title:'富文本编辑器demo'" >
            <div style="width: 900px;margin: 10px;border: 1px solid;">
                <strong>demo内容：</strong>富文本编辑器页面使用,1.初始设定值,2.页面处理,传值到后台<br/>
                <strong>适 用 场 景：</strong>邮件,商品详情,通知公告等富文本信息<br/>
                <strong>使 用 说 明：</strong> 1.点击页面下方按钮,了解相应功能按钮作用 2.输入值点击[保存]可以在后台获取值<br/>
                <strong>注 意 事 项：</strong>详见开发手册及代码<br/>
                <strong>特 别 提 醒：</strong>富文本编辑器图片,需要设置回显地址,且后台存储逻辑需要根据业务进行调整
            </div>
			<form id="submitForm" class="hgform">
			    <input type="hidden" id="ueditorContent" name="ueditorContent" >
			    <table class="hgtable" width="900px">
			        <tr>
			            <td align="right">名称：</td>
			            <td>
			                <input name="name">
			            </td>
			            <td align="right">类别：</td>
			            <td>
			                <input name="type">
			            </td>
			        </tr>
			    </table>
			</form>
			<div style="margin: 10px;">
			    <!-- 只能写 script来创建编辑器,不能书写textarea, -->
			    <script id="editor" type="text/plain" style="width:900px;height:400px;">${testInfo}</script>
			</div>
			<div>
			    <a href="javascript:void(0);" class="a_blue" onclick="saveUeditorForm(this);"
			         style="margin-left: 860px;"><em>保存</em></a>
			</div>
			<fieldset style="width: 920px;border:1px solid;">
			    <legend>功能点及说明</legend>
			    <label>文件上传是否使用ftp保存图片,是否在本地保存文件,需要在config.json文件内定义</label>
				<div id="btns">
				    <a href="javascript:void(0);" class="a_green" onclick="getContent();"><em>获得内容</em></a>
				    <a href="javascript:void(0);" class="a_green" onclick="setContent(true)"><em>追加内容</em></a>
				    <a href="javascript:void(0);" class="a_green" onclick="hasContent()"><em>判断是否有内容</em></a>
				    <a href="javascript:void(0);" class="a_green" onclick="setFocus()"><em>使编辑器获得焦点</em></a>
				    <a href="javascript:void(0);" class="a_green" onmousedown="setblur(event)" ><em>编辑器失去焦点</em></a>
				    <a href="javascript:void(0);" class="a_green" onclick="insertHtml()"><em>插入给定的内容</em></a>
				    <a href="javascript:void(0);" class="a_green" id="enable" onclick="setEnabled()"><em>可以编辑</em></a>
				    <a href="javascript:void(0);" class="a_green" onclick="setDisabled()"><em>不可编辑</em></a>
				    <a href="javascript:void(0);" class="a_green" onclick=" UE.getEditor('editor').setHide()"><em>隐藏编辑器</em></a>
				    <a href="javascript:void(0);" class="a_green" onclick=" UE.getEditor('editor').setShow()"><em>显示编辑器</em></a>
				    <a href="javascript:void(0);" class="a_green" onclick=" UE.getEditor('editor').setHeight(300)"><em>高度定死300</em></a>
				</div>
				<div>
				    <a href="javascript:void(0);" class="a_orange" onclick="createEditor()"><em>创建编辑器</em></a>
				    <a href="javascript:void(0);" class="a_orange" onclick="deleteEditor()"><em>删除编辑器</em></a>
				</div>
			</fieldset>
			<br/>
        </div>
    </div>
<script type="text/javascript">
	function saveUeditorForm(button){
		$(button).hide();
	    //获取富文本编辑器,将值写入到form内的隐藏input框
	    $("#ueditorContent").val(UE.getEditor('editor').getContent());
	    var data=$("#submitForm").serialize();
	    //当前案例发送的邮件,未添加附件,
	    HgUtil.post("/common/demo/ueditor/saveUeditorForm", data, function(data){
	        //按钮恢复可用
	        $(button).show();
	        if(data.success){
	            HgUi.ok("保存成功", function(){
	                //TODO
	            });
	        }else{
	            HgUi.error("保存失败!"+data.msg, function(){
	                //TODO
	            });
	        }
	    });
	    //如有添加附件请使用$.ajaxFileUpload方法,附件先暂存到临时目录再进行提交,--邮件的附件只能添加服务器本地的文件
	}


     //必须使用延时加载方式,不然easyui的样式冲突,
     setTimeout(function(){
    	//先销毁,再创建,解决第二次打开页面时,不能成功创建的问题
    	UE.delEditor('editor');
		//实例化编辑器
		//创建全量的工具栏编辑器,工具栏配置项可以参考ueditor.config.js,已手动备注各属性含义,yyzh整理
		UE.getEditor('editor',{
			maximumWords:500//最大字符数
		});
     }, 100);
    
    //创建简单功能工具栏的编辑器
    /* var ue = UE.getEditor('editor',{
        //这里可以选择自己需要的工具按钮名称,此处仅选择如下五个
        toolbars:[['FullScreen', 'Source', 'Undo', 'Redo','Bold','test']],
        //focus时自动清空初始化时的内容
        autoClearinitialContent:true,
        //关闭字数统计
        wordCount:false,
        //关闭elementPath
        elementPathEnabled:false,
        //默认的编辑区域高度
        initialFrameHeight:300
        //更多其他参数，请参考ueditor.config.js中的配置项
    }); */

    //设置失去焦点
    function setblur(e){
        UE.getEditor('editor').blur();
        UE.dom.domUtils.preventDefault(e)
    }
    //设置编辑器内容
    function insertHtml() {
        var value = prompt('插入html代码', '');
        UE.getEditor('editor').execCommand('insertHtml', value)
    }
    //创建编辑器
    function createEditor() {
        enableBtn();
        UE.getEditor('editor',{
            maximumWords:500//最大字符数
        });
    }
    //获取内容
    function getContent() {
        var arr = [];
        arr.push("使用editor.getContent()方法可以获得编辑器的内容");
        arr.push("内容为：");
        arr.push(UE.getEditor('editor').getContent());
        alert(arr.join("\n"));
    }
    //焦点位置插入内容
    function setContent(isAppendTo) {
        var arr = [];
        arr.push("使用editor.setContent('欢迎使用ueditor')方法可以设置编辑器的内容");
        UE.getEditor('editor').setContent('欢迎使用ueditor', isAppendTo);
        alert(arr.join("\n"));
    }
    //设置不可操作
    function setDisabled() {
        UE.getEditor('editor').setDisabled('fullscreen');
        disableBtn("enable");
    }
    //设置可以操作
    function setEnabled() {
        UE.getEditor('editor').setEnabled();
        enableBtn();
    }
    //判断内容是否为空
    function hasContent() {
        var arr = [];
        arr.push("使用editor.hasContents()方法判断编辑器里是否有内容");
        arr.push("判断结果为：");
        arr.push(UE.getEditor('editor').hasContents());
        alert(arr.join("\n"));
    }
    //获取焦点
    function setFocus() {
        UE.getEditor('editor').focus();
    }
    //销毁编辑器
    function deleteEditor() {
        disableBtn();
        UE.delEditor('editor');
    }
    //操作按钮不可操作
    function disableBtn(str) {
    	$("#btns a").each(function(index,obj){
   			if (obj.id == str) {
    			$(obj).show();
            } else {
            	$(obj).hide();
            }
    	});
    }
    //按钮可以操作
    function enableBtn() {
    	$("#btns a").each(function(index,obj){
              $(obj).show();
        });
    }

</script>
</body>
</html>