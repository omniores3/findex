define(['jquery', 'bootstrap', 'backend', 'table', 'form'], function ($, undefined, Backend, Table, Form) {

    var Controller = {
        index: function () {
            // 初始化表格参数配置
            Table.api.init({
                extend: {
                    index_url: 'groupaudit/index' + location.search,
                    add_url: 'groupaudit/add',
                    edit_url: 'groupaudit/edit',
                    del_url: 'groupaudit/del',
                    multi_url: 'groupaudit/multi',
                    import_url: 'groupaudit/import',
                    table: 'groupaudit',
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
                        {field: 'user', title: __('User_id')},
                        {field: 'group', title: __('Groupid')},
                        {field: 'groupname', title: __('Groupname')},
                        {field: 'groupusername', title: __('Groupusername'),
                            formatter: function(value, row, index) {
                                if(row.groupusername === "" || row.groupusername === null){
                                    return "";
                                }else {
                                    return "<a href='https://t.me/" + row.groupusername + "'>@" + row.groupusername + "</a>";
                                }
                            }
                        },
                        {field: 'grouptype', title: __('Grouptype'),
                            formatter: function(value, row, index) {
                                return __('group_lang')[row.grouptype];
                            }
                        },
                        {field: 'groupcount', title: __('Groupcount')},
                        {field: 'is_search', title: __('Is_search'), operate: 'BETWEEN',
                            formatter: function(value, row, index) {
                                return __('search_lang')[row.is_search];
                            }
                        },
                        {field: 'is_welcome', title: __('Is_welcome'), operate: 'BETWEEN',
                            formatter: function(value, row, index) {
                                return __('' + row.is_welcome);
                            }},
                        {field: 'is_timer', title: __('Is_timer'),
                            formatter: function(value, row, index) {
                                return __('' + row.is_timer);
                            }},
                        {field: 'is_top', title: __('Is_top'),
                            formatter: function(value, row, index) {
                                return __('' + row.is_top);
                            }},
                        {field: 'status', title: __('Status'),

                            formatter: function(value, row, index) {
                                return [
                                    '<div class="btn-group">',
                                    '<button type="button" class="btn btn-warning btn-xs dropdown-toggle" data-toggle="dropdown">',
                                    __('status_lang')[row.status] + '<span class="caret"></span>',
                                    '</button>',
                                    '<ul class="dropdown-menu">',
                                    '<li><a href="javascript:;" class="btn-balance" onclick="setStatus(\''+row.id+'\',\'2\',\''+row.status+'\')">'+__('status_lang')['2']+'</a></li>',
                                    '<li><a href="javascript:;" class="btn-balance" onclick="setStatus(\''+row.id+'\',\'1\',\''+row.status+'\')">'+__('status_lang')['1']+'</a></li>',
                                    '<li><a href="javascript:;" class="btn-balance" onclick="setStatus(\''+row.id+'\',\'-1\',\''+row.status+'\')">'+__('status_lang')['-1']+'</a></li>',
                                    '<li><a href="javascript:;" class="btn-balance" onclick="setStatus(\''+row.id+'\',\'-2\',\''+row.status+'\')">'+__('status_lang')['-2']+'</a></li>',
                                    '</ul>',
                                    '</div>'
                                ].join('');
                            }
                        },
                        {field: 'lang', title: __('Lang')},
                        {field: 'lables', title: __('Lables')},
                        {field: 'category', title: __('Category')},
                        {field: 'kd', title: __('Kd')},
                        {field: 'addtime', title: __('Addtime'), operate:'RANGE', addclass:'datetimerange', formatter: Table.api.formatter.datetime},
                        {field: 'updatetime', title: __('Updatetime'), operate:'RANGE', addclass:'datetimerange', formatter: Table.api.formatter.datetime},
                    ]
                ]
            });

            // 为表格绑定事件
            Table.api.bindevent(table);
        },
        recyclebin: function () {
            // 初始化表格参数配置
            Table.api.init({
                extend: {
                    'dragsort_url': ''
                }
            });

            var table = $("#table");

            // 初始化表格
            table.bootstrapTable({
                url: 'groupaudit/recyclebin' + location.search,
                pk: 'id',
                sortName: 'id',
                columns: [
                    [
                        {checkbox: true},
                        {field: 'id', title: __('Id')},
                        {
                            field: 'deletetime',
                            title: __('Deletetime'),
                            operate: 'RANGE',
                            addclass: 'datetimerange',
                            formatter: Table.api.formatter.datetime
                        },
                        {
                            field: 'operate',
                            width: '140px',
                            title: __('Operate'),
                            table: table,
                            events: Table.api.events.operate,
                            buttons: [
                                {
                                    name: 'Restore',
                                    text: __('Restore'),
                                    classname: 'btn btn-xs btn-info btn-ajax btn-restoreit',
                                    icon: 'fa fa-rotate-left',
                                    url: 'groupaudit/restore',
                                    refresh: true
                                },
                                {
                                    name: 'Destroy',
                                    text: __('Destroy'),
                                    classname: 'btn btn-xs btn-danger btn-ajax btn-destroyit',
                                    icon: 'fa fa-times',
                                    url: 'groupaudit/destroy',
                                    refresh: true
                                }
                            ],
                            formatter: Table.api.formatter.operate
                        }
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


function setStatus(id,status,editstatus){
    let isBound = false;
    if(editstatus === status){
        layer.alert(__('Status_error'));
        return;
    }
    layer.confirm(__('Confirm_Change_Status'),{
        btn: [__('submit'),__('clone')] //按钮
    }, function(remark, index) {
        if(!isBound) {
            $.post('groupaudit/setstatus', {
                id: id,
                status: status,
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