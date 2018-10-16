<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<%@ include file="/WEB-INF/jsp/common/meta.jsp"%>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>多附件上传demo</title>
</head>
<body>
    <div class="easyui-layout" fit="true">
        <div data-options="region:'center',border:false" style="padding: 10px; ">
            <form id="filesUploadForm" class="hgform">
                <input id="filecount" type="hidden" value="1">
                <table id="fileTable" class="hgtable">
                    <tr>
                        <td align="right" width="30%">参数1：</td>
                        <td width="70%">
                            <input type="text" name="param1" >
                        </td>
                    </tr>
                    <tr>
                        <td align="right">参数2：</td>
                        <td>
                            <input type="text" name="param2" >
                        </td>
                    </tr>
                    <tr>
                        <td align="right">附件列表：</td>
                        <td colspan="3">
                            <input id="file1" name="file1" type="file">
                            <a class="easyui-linkbutton" iconCls="icon_auto_colorful__plus" 
                                onclick="addMore();">更多</a>
                        </td>
                    </tr>
                </table>
            </form>
        </div>
        <div data-options="region:'south',border:true" style="padding: 0px;background-color:rgb(245,245,245);">
                <a href="javascript:void(0);" style="float:right;margin:3px;" class="btn btn-success btn-sm" onclick="saveCountsFiles();" ><i class="fa fa-save"></i>保存</a>
        </div>
    </div>
    <script type="text/javascript">
    //更多
    function addMore(){
        var index=Number($("#filesUploadForm #filecount").val())+1;
        var html=
            '<tr id="fileTr'+index+'">'+
            '   <td></td>'+
            '   <td>'+
            '       <input type="file"  id="file'+index+'" name="file'+index+'">'+
            '       <a class="easyui-linkbutton" iconCls="icon_auto_delete_16px"'+
            '           onclick="delTr('+index+');">删除</a>'+
            '   </td>'+
            '</tr>';
        $("#fileTable").append(html);
        //调用解析器,解析拼接的html
        $.parser.parse('#fileTr'+index); 
        $("#filesUploadForm #filecount").val(index);
    }
    //删除行
    function delTr(index){
        $("#fileTable #fileTr"+index).remove();
    }
    //保存
    function saveCountsFiles(){
        //自动获取需要上传的附件ID,封装为数组
        var filecount=$("#filesUploadForm #filecount").val();
        var fileIDArray=new Array();
        //数组填充,记数
        var count=0;
        for(var i=1;i<=filecount;i++){
            var obj=$("#file"+i);
            if(obj!=null && $("#file"+i).val()!='' && $("#file"+i).val()!=undefined){
                fileIDArray[count]=obj.attr('id');
                count++;
            }
        }
        if(fileIDArray.length<1 ){
            $.messager.alert("提示","需要至少选择一个附件!","warning");
            return false;
        }
        //组装form内参数封装为Map(Name值不可重复)
        var params=HgUtil.paramArrayToMap($("#filesUploadForm").serializeArray());
        var submitUrl = G_CTX_PATH+"/common/demo/fileDemo/filesUpload.do";
        
        $.messager.confirm("确认", "确认提交吗?", function(r){
            if (r){
                $.messager.progress({
                    title:"稍等",
                    msg:"正在提交..."
                });
                $.ajaxFileUpload({ 
                    url:submitUrl,     
                    secureuri:false,  
                    type: 'POST',
                    data:params,
                    fileElementId:fileIDArray,  //文件选择框的id属性 
                    dataType:'text',            
                    success:function(result){
                        $.messager.progress("close");
                        if (result == "success") {
                            $.messager.alert("提示","操作成功!","info",function(){
                                
                            });
                        }else {
                            $.messager.alert("提示","操作失败!"+result,"error");
                        }       
                    },
                    error:function(data, status, e){ //服务器响应失败时的处理函数 
                        $.messager.progress("close");
                        $.messager.alert("提示","操作失败!","info");
                    }     
                });
            }
        });
    }
    </script>
</body>
</html>