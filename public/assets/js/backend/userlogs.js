define(['jquery', 'bootstrap', 'backend', 'table', 'form'], function ($, undefined, Backend, Table, Form) {

    var Controller = {
        index: function () {
            // 初始化表格参数配置
            Table.api.init({
                extend: {
                    index_url: 'userlogs/index' + location.search,
                    add_url: 'userlogs/add',
                    edit_url: 'userlogs/edit',
                    del_url: 'userlogs/del',
                    multi_url: 'userlogs/multi',
                    import_url: 'userlogs/import',
                    table: 'userlogs',
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
                        {field: 'admin', title: __('Admin_id')},
                        {field: 'action_type', title: __('Action_type'),formatter:function(value,row,index){
                                return __('action_type_lang')[row.action_type];
                            }},
                        {field: 'action_detail', title: __('Action_detail'),formatter:function(value,row,index){
                                return __('action_type_message')[row.action_type] + __(row.action_detail);
                            }},
                        {field: 'before_status', title: __('Before_status')},
                        {field: 'after_status', title: __('After_status')},
                        {field: 'balance_before_change', title: __('balance_before_change'), operate: 'BETWEEN'},
                        {field: 'balance_after_change', title: __('balance_after_change'), operate: 'BETWEEN'},
                        {field: 'balance_change', title: __('Balance_change'), operate: 'BETWEEN'},
                        {field: 'frozen_before_balance_change', title: __('frozen_before_balance_change'), operate: 'BETWEEN'},
                        {field: 'frozen_after_balance_change', title: __('frozen_after_balance_change'), operate: 'BETWEEN'},
                        {field: 'frozen_balance_change', title: __('Frozen_balance_change'), operate: 'BETWEEN'},
                        {field: 'transaction', title: __('Transaction_id')},
                        {field: 'ip_address', title: __('Ip_address')},
                        {field: 'user_agent', title: __('User_agent')},
                        {field: 'create_time', title: __('Create_time'), operate:'RANGE', addclass:'datetimerange', formatter: Table.api.formatter.datetime},
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
                url: 'tips/recyclebin' + location.search,
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
                                    url: 'userlogs/restore',
                                    refresh: true
                                },
                                {
                                    name: 'Destroy',
                                    text: __('Destroy'),
                                    classname: 'btn btn-xs btn-danger btn-ajax btn-destroyit',
                                    icon: 'fa fa-times',
                                    url: 'userlogs/destroy',
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
