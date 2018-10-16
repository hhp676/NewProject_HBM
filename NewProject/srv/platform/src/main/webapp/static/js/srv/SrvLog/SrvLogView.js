

var srvLogSearchForm = $("#srvLogSearchForm");
var SrvLog = {};
var SrvLogTable = $('#SrvLogTable').DataTable({
    "processing": true,
    "serverSide": true,
    "lengthMenu": [[15, 25, 50], [15, 25, 50]],
    "searching": false,
    "ordering": false,
    "ajax": {
        "url": G_CTX_ADMIN_PATH + "/SrvLog/list",
        "data": function (reqData) {
            HgUi.formToData(reqData , $(srvLogSearchForm).serializeArray());
            return reqData;
        }
    },
    "columns": [
        { "data": 'id', "visible" : false},
        { "data": "reqUri" },
        {
            "data": "reqUserid",
            "render": function ( data, type, row ) {
                return (row.sysUser)?row.sysUser.userName:'';
            }
        },
        { "data": "processTime" },
        {
            "data": "result" ,
            "render": function ( data, type, row ) {
                return (data==1)?'<span  class="label label-success">成功</span>':'<span class="label label-danger">失败</span>';
            }
        },
        { "data": "ip" },
        { "data": "consumerIp" },
        { "data": "providerIp" },
        {
            "data": "beginTime" ,
            "render": function ( data, type, row ) {
                return (new Date(data)).format("yyyy-MM-dd hh:mm:ss");
            }
        }
    ]
});

SrvLog.processTimeSlider = $(srvLogSearchForm).find('.slider').slider();

$(srvLogSearchForm).find("input[name='bo.filterTime']").daterangepicker({
    locale : {
        format: 'YYYY-MM-DD HH:mm:ss',
        separator : ' - ',
        customRangeLabel : '自定义',
        applyLabel : '确定',
        cancelLabel : '取消',
        fromLabel : '起始时间',
        toLabel : '结束时间',
        daysOfWeek : [ '日', '一', '二', '三', '四', '五', '六' ],
        monthNames : [ '一月', '二月', '三月', '四月', '五月', '六月', '七月', '八月', '九月', '十月', '十一月', '十二月' ],
        firstDay : 1,
        startDate: moment().startOf('day'),
        endDate: moment().endOf('day'),
    },
    maxDate:moment(),
    autoUpdateInput: false
});
$(srvLogSearchForm).find("input[name='bo.filterTime']").on('apply.daterangepicker', function(ev, picker) {
    $(this).val(picker.startDate.format('YYYY-MM-DD HH:mm:ss') + ' - ' + picker.endDate.format('YYYY-MM-DD HH:mm:ss'));
});

$(srvLogSearchForm).find("input[name='bo.filterTime']").on('cancel.daterangepicker', function(ev, picker) {
});

$(srvLogSearchForm).find(".searchBtn").on('click',function (){
    SrvLogTable.draw();
    return false;
})

$(srvLogSearchForm).find(".clearBtn").on('click',function (){
    $(srvLogSearchForm)[0].reset()
    SrvLog.processTimeSlider.slider('refresh')
    SrvLogTable.draw();
    return false;
})


