define(['jquery', 'bootstrap', 'backend', 'table', 'form'], function ($, undefined, Backend, Table, Form) {

    var Controller = {
        index: function () {
            // 初始化表格参数配置
            Table.api.init({
                extend: {
                    index_url: 'advkey/index' + location.search,
                    add_url: 'advkey/add',
                    edit_url: 'advkey/edit',
                    del_url: 'advkey/del',
                    multi_url: 'advkey/multi',
                    import_url: 'advkey/import',
                    table: 'advkey',
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
                        {field: 'keyword', title: __('Keyword'), operate: 'LIKE'},
                        {field: 'user_id', title: __('User_id'),formatter:function(value,row,index){
                                return row.tg_user.tnick;
                            }},
                        {field: 'group_id', title: __('Group_id'), operate: 'LIKE'},
                        {field: 'amount', title: __('Amount'), operate:'BETWEEN',formatter:function(value,row,index){
                                return row.amount + " USDT";
                            }},
                        {field: 'lang', title: __('Lang'), operate: 'LIKE'},
                        {field: 'status', title: __('Status'), searchList: {"-3":__('Status -3'),"-2":__('Status -2'),"-1":__('Status -1'),"0":__('Status 0'),"1":__('Status 1')},formatter:function(value,row,index){
                                return [
                                    '<div class="btn-group">',
                                    '<button type="button" class="btn btn-warning btn-xs dropdown-toggle" data-toggle="dropdown">',
                                    __('keywordadvsStatus')[row.status] + '<span class="caret"></span>',
                                    '</button>',
                                    '<ul class="dropdown-menu">',
                                    '<li><a href="javascript:;" class="btn-balance" onclick="setStatus('+row.id+',\'-4\',\''+row.status+'\')">'+__('keywordadvsStatus')["-4"]+'</a></li>',
                                    '<li><a href="javascript:;" class="btn-balance" onclick="setStatus('+row.id+',\'-2\',\''+row.status+'\')">'+__('keywordadvsStatus')["-2"]+'</a></li>',
                                    '</ul>',
                                    '</div>'
                                ].join('');
                            }},
                        {field: 'createtime', title: __('Createtime'), operate: 'LIKE',formatter: Table.api.formatter.datetime},
                        {field: 'updatetime', title: __('Updatetime'), operate: 'LIKE',formatter: Table.api.formatter.datetime},
                        {field: 'operate', title: __('Operate'), table: table, events: Table.api.events.operate}
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

function setStatus(id,editStatus,status){
    let isBound = false;
    if(editStatus === status){
        layer.alert(__('Status_error'));
        return;
    }
    layer.confirm(__('Confirm_Change_Status'),{
        btn: [__('submit'),__('clone')] //按钮
    }, function(remark, index) {
        if(!isBound) {
            $.post('advkey/setstatus', {
                id: id,
                status: editStatus,
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