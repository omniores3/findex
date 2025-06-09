define(['jquery', 'bootstrap', 'backend', 'table', 'form'], function ($, undefined, Backend, Table, Form) {

    var Controller = {
        index: function () {
            // 初始化表格参数配置
            Table.api.init({
                extend: {
                    index_url: 'reports/index' + location.search,
                    add_url: 'reports/add',
                    edit_url: 'reports/edit',
                    del_url: 'reports/del',
                    multi_url: 'reports/multi',
                    import_url: 'reports/import',
                    table: 'reports',
                }
            });

            var table = $("#table");

            // 初始化表格
            table.bootstrapTable({
                url: $.fn.bootstrapTable.defaults.extend.index_url,
                pk: 'id',
                sortName: 'id',
                columns: [
                    [
                        {checkbox: true},
                        {field: 'id', title: __('Id')},
                        {field: 'report_id', title: __('Report_id'),formatter:function(value,row,index){
                                return row.report.title;
                            }},
                        {field: 'user_id', title: __('User_id'),formatter:function(value,row,index){
                                return row.tg_user.tnick + "(<a href='https://t.me/"+row.tg_user.tusername+"' target='_blank'>@"+row.tg_user.tusername+"</a>)";
                            }},
                        {field: 'groups_id', title: __('Groups_id'), operate: 'LIKE'},
                        {field: 'status', title: __('Status'), searchList: {"-2":__('Status -2'),"-1":__('Status -1'),"0":__('Status 0'),"1":__('Status 1')}, formatter: Table.api.formatter.status},
                        {field: 'createtime', title: __('Createtime'), operate: 'LIKE',formatter: Table.api.formatter.datetime},
                        {field: 'updatetime', title: __('Updatetime'), operate: 'LIKE',formatter: Table.api.formatter.datetime},
                        {field: 'operate', title: __('Operate'), table: table, events: Table.api.events.operate, formatter: function(value, row, index) {
                                return [
                                    '<button class="btn btn-info btn-xs btn-detail" onclick="viewReport('+row.id+')"><i class="fa fa-eye"></i> '+__('Detail')+'</button> ',
                                    '<div class="btn-group">',
                                    '<button type="button" class="btn btn-warning btn-xs dropdown-toggle" data-toggle="dropdown">',
                                    __('Status Management')+' <span class="caret"></span>',
                                    '</button>',
                                    '<ul class="dropdown-menu">',
                                    '<li><a href="javascript:;" class="btn-balance" onclick="setblack('+row.id+','+ row.status +')">'+__('Set black')+'</a></li>',
                                    '<li><a href="javascript:;" class="btn-balance" onclick="setturn('+row.id+','+ row.status +')">'+__('Set turn')+'</a></li>',
                                    '<li><a href="javascript:;" class="btn-balance" onclick="setsuccess('+row.id+')">'+__('Set success')+'</a></li>',
                                    '</ul>',
                                    '</div>'
                                ].join('');
                            }}
                    ]
                ]
            });

            // 为表格绑定事件
            Table.api.bindevent(table);
        },
        add: function () {
            Controller.api.bindevent();
        },
        edit: function () {
            Controller.api.bindevent();
        },
        api: {
            bindevent: function () {
                Form.api.bindevent($("form[role=form]"));
            }
        }
    };
    return Controller;
});


function viewReport(id) {
    layer.open({
        type: 2,
        title: __("viewReport"),
        shadeClose: true,
        shade: 0.8,
        area: ['100%', '100%'],
        content: 'reports/detail?id=' + id
    });
}


function setblack(id,status) {
    if (-2 === status || 1 === status) {
        layer.alert(__('Status_error'));
        return;
    }
    let isBound = false;
    layer.confirm(__('Confirm_Change_Status_setblack'), {
        btn: [__('submit'), __('clone')] //按钮
    }, function (remark, index) {
        if (!isBound) {
            $.post('reports/setblack', {
                id: id
            }, function (res) {
                layer.msg(res.msg);
                if (res.code == 1) {
                    setTimeout(function () {
                        window.location.reload();
                    }, 1000);
                }
            }, 'json');
        }
        isBound = true;
        layer.close(index);
    });
}

    function setturn(id,status){
        if(-2 === status || -1 === status || 1 === status){
            layer.alert(__('Status_error'));
            return;
        }
        let isBound = false;
        layer.prompt({
            title: __("input_text_message_turn"),
            formType: 2
        }, function(remark, index2) {
            if(!isBound) {
                $.post('reports/setturn', {
                    id: id,
                    remark: remark
                }, function (res) {
                    layer.msg(res.msg);
                    if (res.code == 1) {
                        setTimeout(function () {
                            window.location.reload();
                        }, 1000);
                    }
                }, 'json');
            }
            isBound = true;
            layer.close(index2);
        });
    }


    function setsuccess(id,status){
        if (-2 === status || 1 === status) {
            layer.alert(__('Status_error'));
            return;
        }
        let isBound = false;
        layer.confirm(__('Confirm_Change_Status_setsuccess'), {
            btn: [__('submit'), __('clone')] //按钮
        }, function (remark, index) {
            if (!isBound) {
                $.post('reports/setsuccess', {
                    id: id
                }, function (res) {
                    layer.msg(res.msg);
                    if (res.code == 1) {
                        setTimeout(function () {
                            window.location.reload();
                        }, 1000);
                    }
                }, 'json');
            }
            isBound = true;
            layer.close(index);
        });
    }