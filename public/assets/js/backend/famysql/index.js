define(['jquery', 'bootstrap', 'backend', 'table', 'form'], function ($, undefined, Backend, Table, Form) {

    var Controller = {
        indexs: function () {
            // 初始化表格参数配置

            var name = $("#assign-data-name").val();
            var is_admin = $("#assign-data-is_admin").val();
            Table.api.init({
                extend: {
                    index_url: 'famysql/index/indexs?name=' + name + '&is_admin=' + is_admin,
                    add_url: 'famysql/index/index_add?table=' + name,
                },
                showExport: false,//导出按钮导出整个表的所有行
                showToggle: false,//切换卡片视图和表格视图
                showColumns: false,//切换显示隐藏列
                search: false,//关闭快速搜索
                commonSearch: false,//关闭通用搜索
                // pagination: false,
            });

            var table = $("#table");
            // 初始化表格
            table.bootstrapTable({
                url: $.fn.bootstrapTable.defaults.extend.index_url,
                pk: 'id',
                sortName: 'id',
                columns: [
                    [
                        { field: 'name', title: __('Name') },
                        { field: 'column_name', title: __('Column_name') },
                        { field: 'non_unique', title: __('Non_unique') },
                        {
                            field: 'operate',
                            title: __('Table Operate'),
                            buttons: [
                                {
                                    name: 'index_edit',
                                    icon: 'fa fa-pencil',
                                    title: __('Edit'),
                                    extend: 'data-toggle="tooltip"',
                                    url: function (row) {
                                        return Fast.api.fixurl("famysql/index/index_edit?table=" + name + "&name=" + row.name);
                                    },
                                    classname: 'btn btn-xs btn-success btn-dialog'
                                },
                                {
                                    name: 'index_del',
                                    icon: 'fa fa-trash',
                                    title: __('Del'),
                                    extend: 'data-toggle="tooltip"',
                                    url: function (row) {
                                        return Fast.api.fixurl("famysql/index/index_del?table=" + name + "&name=" + row.name);
                                    },
                                    classname: 'btn btn-xs btn-danger btn-ajax',
                                    confirm: function (row) {
                                        return '是否确定删除该“' + row.name + '”索引，不可恢复？';
                                    },
                                    success: function (data, ret) {
                                        $(".btn-refresh").trigger("click"); //刷新数据
                                    },
                                    error: function (data, ret) {
                                        console.log(data, ret);
                                        Layer.alert(ret.msg);
                                        return false;
                                    }
                                }
                            ],
                            table: table,
                            events: Table.api.events.operate,
                            formatter: function (value, row, index) {
                                var that = $.extend({}, this);
                                if (!row.is_admin || row.non_unique === 'PRIMARY') {
                                    return '-';
                                }
                                return Table.api.formatter.operate.call(that, value, row, index);
                            }
                        }
                    ]
                ]
            });

            // 为表格绑定事件
            Table.api.bindevent(table);
        },
        index_add: function () {
            Controller.api.bindevent();
        },
        index_edit: function () {
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
