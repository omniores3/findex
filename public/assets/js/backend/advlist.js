define(['jquery', 'bootstrap', 'backend', 'table', 'form'], function ($, undefined, Backend, Table, Form) {

    var Controller = {
        index: function () {
            // 初始化表格参数配置
            Table.api.init({
                extend: {
                    index_url: 'advlist/index' + location.search,
                    add_url: 'advlist/add',
                    edit_url: 'advlist/edit',
                    del_url: 'advlist/del',
                    multi_url: 'advlist/multi',
                    import_url: 'advlist/import',
                    table: 'advlist',
                }
            });

            var table = $("#table");

            // 初始化表格
            table.bootstrapTable({
                url: $.fn.bootstrapTable.defaults.extend.index_url,
                pk: 'id',
                sortName: 'id',
                fixedColumns: true,
                fixedRightNumber: 1,
                columns: [
                    [
                        {checkbox: true},
                        {field: 'id', title: __('Id')},
                        {field: 'advtype', title: __('Advtype'), operate: 'LIKE',formatter:function(value,row,index){
                                return __("advtypes")[row.advtype];
                            }},
                        {field: 'user_id', title: __('User'), operate: 'LIKE',formatter:function(value,row,index){
                            return row.tg_user.tnick;
                        }},
                        {field: 'title', title: __('Title'), operate: 'LIKE'},
                        {field: 'url', title: __('Url'), operate: 'LIKE', formatter: Table.api.formatter.url},
                        {field: 'image', title: __('Image'), operate: false, events: Table.api.events.image, formatter: Table.api.formatter.image},
                        {field: 'lang', title: __('Lang'), operate: 'LIKE'},
                        {field: 'status', title: __('Status'), searchList: {"-2":__('Status -2'),"1":__('Status 1'),"0":__('Status 0'),"2":__('Status 2')},formatter:function(value,row,index){
                return [
                    '<div class="btn-group">',
                    '<button type="button" class="btn btn-warning btn-xs dropdown-toggle" data-toggle="dropdown">',
                    __('advStatus')[row.status] + '<span class="caret"></span>',
                    '</button>',
                    '<ul class="dropdown-menu">',
                    '<li><a href="javascript:;" class="btn-balance" onclick="setStatus('+row.id+',\'-1\',\''+row.status+'\')">'+__('advStatus')["-1"]+'</a></li>',
                    '<li><a href="javascript:;" class="btn-balance" onclick="setStatus('+row.id+',\'1\',\''+row.status+'\')">'+__('advStatus')["1text"]+'</a></li>',
                    '<li><a href="javascript:;" class="btn-balance" onclick="setStatus('+row.id+',\'2\',\''+row.status+'\')">'+__('advStatus')["2"]+'</a></li>',
                    '</ul>',
                    '</div>'
                ].join('');
            }},
                        {field: 'advorder', title: __('Advorder'), operate: 'LIKE'},
                        {field: 'createtime', title: __('Createtime'), operate: 'LIKE',formatter: Table.api.formatter.datetime},
                        {field: 'updatetime', title: __('Updatetime'), operate: 'LIKE',formatter: Table.api.formatter.datetime},
                        {field: 'endtime', title: __('Endtime'), operate: 'LIKE',formatter: Table.api.formatter.datetime},
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
            $.post('advlist/setstatus', {
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