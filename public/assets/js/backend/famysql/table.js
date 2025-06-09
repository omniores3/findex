define(['jquery', 'bootstrap', 'backend', 'table', 'form', 'selectpage'], function ($, undefined, Backend, Table, Form, selectPage) {

    var Controller = {
        index: function () {
            // 初始化表格参数配置
            Table.api.init({
                extend: {
                    index_url: 'famysql/table/index',
                    add_url: Config.group ? 'famysql/table/table_add?group=' + Config.group : 'famysql/table/table_add',
                },
                showExport: false,//导出按钮导出整个表的所有行
                showToggle: false,//切换卡片视图和表格视图
                showColumns: false,//切换显示隐藏列
                search: false,//关闭快速搜索
                commonSearch: false,//关闭通用搜索
            });
            var table = $("#table");

            // 初始化表格
            table.bootstrapTable({
                url: $.fn.bootstrapTable.defaults.extend.index_url,
                pk: 'id',
                sortName: 'id',
                columns: [
                    [
                        { field: 'id', title: __('Id') },
                        { field: 'name', title: __('Name') },
                        { field: 'engine', title: __('Engine'), width: '80px' },
                        { field: 'charset', title: __('Charset'), width: '80px' },
                        { field: 'collation', title: __('Collation'), width: '150px' },
                        { field: 'comment', title: __('Comment') },
                        { field: 'rows', title: __('Rows') },
                        { field: 'createtime', title: __('Create time') },
                        { field: 'updatetime', title: __('Update time') },
                        {
                            field: 'operate', title: __('Table Operate'), width: '400px', table: table, operate: false,
                            events: {
                                'click .btn-copy-1': function (e, value, row) {
                                    Layer.prompt({
                                        title: "请输入你需要新复制的数据表名",
                                        success: function (layero) {
                                            var name = row.name;
                                            var name_arr = name.split("_");
                                            if (row.is_has) {
                                                name_arr.shift()
                                            }
                                            const str = name_arr.join('_');
                                            $("input", layero).prop("placeholder", "例如：test，请不要加前缀").val(str);
                                        }
                                    }, function (value) {
                                        Fast.api.ajax({
                                            url: "famysql/table/copy?name=" + row.name + "&type=1",
                                            data: { table: value },
                                        }, function (data, ret) {
                                            Layer.closeAll();
                                            parent.location.reload();
                                            return false;
                                        });
                                    });
                                },
                                'click .btn-copy-2': function (e, value, row) {
                                    Layer.prompt({
                                        title: "请输入你需要新复制的数据表名",
                                        success: function (layero) {
                                            var name = row.name;
                                            var name_arr = name.split("_");
                                            if (row.is_has) {
                                                name_arr.shift()
                                            }
                                            const str = name_arr.join('_');
                                            $("input", layero).prop("placeholder", "例如：test，请不要加前缀").val(str);
                                        }
                                    }, function (value) {
                                        Fast.api.ajax({
                                            url: "famysql/table/copy?name=" + row.name + "&type=2",
                                            data: { table: value },
                                        }, function (data, ret) {
                                            Layer.closeAll();
                                            parent.location.reload();
                                            return false;
                                        });
                                    });
                                }
                            },
                            buttons: [
                                {
                                    name: 'copy',
                                    text: __('Copy 1'),
                                    title: __('Copy 1'),
                                    dropdown: __('Copy'),
                                    classname: 'btn btn-xs btn-warning btn-copy-1',
                                    icon: 'fa fa-copy',
                                },
                                {
                                    name: 'copy-2',
                                    text: __('Copy 2'),
                                    title: function (row) {
                                        return __('Copy 2') + "(" + row.rows + ")";
                                    },
                                    dropdown: __('Copy'),
                                    classname: 'btn btn-xs btn-warning btn-copy-2',
                                    icon: 'fa fa-copy',
                                },
                                {
                                    name: 'truncate',
                                    text: function (row) {
                                        return __('Truncate') + "(" + row.rows + ")";
                                    },
                                    title: function (row) {
                                        return __('Truncate') + "(" + row.rows + ")";
                                    },
                                    dropdown: __('More Table Operate'),
                                    classname: 'btn btn-xs btn-danger btn-truncate',
                                    icon: 'fa fa-minus-circle',
                                    url: function (row) {
                                        return Fast.api.fixurl("famysql/table/truncate?name=" + row.name);
                                    },
                                    classname: 'btn btn-xs btn-danger btn-ajax',
                                    confirm: function (row) {
                                        return '是否确定清空该“' + row.name + '”数据表？';
                                    },
                                    success: function (data, ret) {
                                        $(".btn-refresh").trigger("click"); //刷新数据
                                    },
                                    visible: function (row) {
                                        return row.is_admin !== 0;
                                    },
                                    error: function (data, ret) {
                                        Layer.alert(ret.msg);
                                        return false;
                                    }
                                },
                                {
                                    name: 'optimize',
                                    text: __('Optimize'),
                                    title: __('Optimize'),
                                    dropdown: __('More Table Operate'),
                                    classname: 'btn btn-xs btn-danger btn-optimize',
                                    icon: 'fa fa-exclamation-triangle',
                                    url: function (row) {
                                        return Fast.api.fixurl("famysql/table/optimize?name=" + row.name);
                                    },
                                    classname: 'btn btn-xs btn-danger btn-ajax',
                                    confirm: function (row) {
                                        return '是否确定优化该“' + row.name + '”数据表？';
                                    },
                                    success: function (data, ret) {
                                        $(".btn-refresh").trigger("click"); //刷新数据
                                    },
                                    visible: function (row) {
                                        return row.is_admin !== 0;
                                    },
                                    error: function (data, ret) {
                                        Layer.alert(ret.msg);
                                        return false;
                                    }
                                },
                                {
                                    name: 'repair',
                                    text: __('Repair'),
                                    title: __('Repair'),
                                    dropdown: __('More Table Operate'),
                                    classname: 'btn btn-xs btn-danger btn-repair',
                                    icon: 'fa fa-check-circle-o',
                                    url: function (row) {
                                        return Fast.api.fixurl("famysql/table/repair?name=" + row.name);
                                    },
                                    classname: 'btn btn-xs btn-danger btn-ajax',
                                    confirm: function (row) {
                                        return '是否确定修复该“' + row.name + '”数据表？';
                                    },
                                    success: function (data, ret) {
                                        $(".btn-refresh").trigger("click"); //刷新数据
                                    },
                                    visible: function (row) {
                                        return row.is_admin !== 0;
                                    },
                                    error: function (data, ret) {
                                        Layer.alert(ret.msg);
                                        return false;
                                    }
                                },
                                {
                                    name: 'editone',
                                    icon: 'fa fa-pencil',
                                    text: __('Edit'),
                                    title: __('Edit'),
                                    dropdown: __('More Table Operate'),
                                    extend: 'data-toggle="tooltip"',
                                    url: function (row) {
                                        return Fast.api.fixurl("famysql/table/table_edit?name=" + row.name);
                                    },
                                    visible: function (row) {
                                        return row.is_admin !== 0;
                                    },
                                    classname: 'btn btn-xs btn-success btn-dialog'
                                },
                                {
                                    name: 'delone',
                                    icon: 'fa fa-trash',
                                    text: __('Del'),
                                    title: __('Del'),
                                    dropdown: __('More Table Operate'),
                                    extend: 'data-toggle="tooltip"',
                                    url: function (row) {
                                        return Fast.api.fixurl("famysql/table/table_del?name=" + row.name);
                                    },
                                    classname: 'btn btn-xs btn-danger btn-ajax',
                                    confirm: function (row) {
                                        return '是否确定删除该“' + row.name + '”数据表，不可恢复？';
                                    },
                                    success: function (data, ret) {
                                        if (ret.data == 0) {
                                            parent.location.reload();
                                        } else {
                                            $(".btn-refresh").trigger("click"); //刷新数据
                                        }
                                    },
                                    visible: function (row) {
                                        return row.is_admin !== 0;
                                    },
                                    error: function (data, ret) {
                                        Layer.alert(ret.msg);
                                        return false;
                                    }
                                },
                                {
                                    name: 'crud',
                                    text: 'CRUD',
                                    title: function (row) {
                                        return "(表" + row.name + ")" + __('CRUD');
                                    },
                                    extend: 'data-area=\'["90%", "90%"]\'',
                                    dropdown: __('More Table Operate'),
                                    classname: 'btn btn-warning btn-xs btn-primary btn-dialog ',
                                    visible: function (row) {
                                        return row.group !== 'system';
                                    },
                                    url: function (row) {
                                        return Fast.api.fixurl('famysql/table/check?addon_name=' + row.group + '&table_name=' + row.name);
                                    },
                                    icon: 'fa fa-terminal',
                                },
                                {
                                    name: 'indexs',
                                    title: __('Index manager'),
                                    text: __('Index manager'),
                                    extend: 'data-area=\'["90%", "90%"]\'',
                                    url: function (row) {
                                        return Fast.api.fixurl("famysql/index/indexs?name=" + row.name + "&is_admin=" + row.is_admin);
                                    },
                                    icon: 'fa fa-list-ol',
                                    classname: 'btn btn-xs btn-danger btn-dialog'
                                },
                                {
                                    name: 'fields',
                                    title: function (row) {
                                        return "(" + row.name + ")" + __('Field manager');
                                    },
                                    text: function (row) {
                                        return __('Field manager') + "(" + row.field_nums + ")";
                                    },
                                    extend: 'data-area=\'["90%", "90%"]\'',
                                    url: function (row) {
                                        return Fast.api.fixurl("famysql/field/fields?name=" + row.name + "&is_admin=" + row.is_admin);
                                    },
                                    icon: 'fa fa-table',
                                    classname: 'btn btn-success btn-xs btn-execute btn-dialog'
                                },
                            ],
                            formatter: Table.api.formatter.operate
                        },
                    ]
                ],
                //启用固定列
                fixedColumns: true,
                //固定右侧列数
                fixedRightNumber: 1,
                queryParams: function (params) {
                    if (Config.group) {
                        params.group = Config.group;
                    }
                    return params;
                },
            });

            // 绑定TAB事件
            $('.panel-heading a[data-toggle="tab"]').on('shown.bs.tab', function (e) {
                var value = $(this).data("value");
                var options = table.bootstrapTable('getOptions');
                options.queryParams = function (params) {
                    params.group = value;
                    return params;
                };
                return false;
            });

            // 为表格绑定事件
            Table.api.bindevent(table);
        },
        backuplist: function () {
            // 初始化表格参数配置
            Table.api.init({
                extend: {
                    index_url: 'famysql/table/backuplist'
                }
            });

            var table = $("#table");

            table.on('load-success.bs.table', function (e, json) {
                if (json && typeof json.rows != 'undefined' && $(".nav-addon li").size() == 1) {
                    var addons = [];
                    $.each(json.rows, function (i, j) {
                        if (addons.indexOf(j.addon) == -1 && j.addon != 'all') {
                            $(".nav-addon").append("<li><a href='javascript:;' data-value='" + j.addon + "'>" + j.addon_name + "</a></li>");
                            addons.push(j.addon);
                        }
                    });
                }
            });

            // 初始化表格
            table.bootstrapTable({
                url: $.fn.bootstrapTable.defaults.extend.index_url,
                columns: [
                    [
                        {
                            field: 'id', title: __('ID'), operate: false, formatter: function (value, row, index) {
                                return index + 1;
                            }
                        },
                        { field: 'addon', title: __('Addon'), visible: false },
                        { field: 'type', title: __('File'), visible: false },
                        {
                            field: 'file', title: __('File'), operate: false, formatter: function (value, row, index) {
                                var url = Fast.api.fixurl("famysql/table/download?file=" + row.file);
                                return '<a href="' + url + '" data-toggle="tooltip" title="' + __('Download file') + '" target="_blank">' + row.file + '</a>';
                            }
                        },
                        { field: 'size', title: __('Size'), operate: false },
                        { field: 'date', title: __('Date'), operate: false },
                        {
                            field: 'operate', title: __('Operate'), table: table, operate: false,
                            buttons: [
                                {
                                    name: 'restore',
                                    text: __('恢复'),
                                    icon: 'fa fa-reply',
                                    classname: 'btn btn-primary btn-restore btn-xs btn-ajax ',
                                    url: function (row) {
                                        return Fast.api.fixurl("famysql/table/restore?action=restore&file=" + row.file);
                                    }
                                },
                                {
                                    name: 'delone',
                                    text: __('Del'),
                                    icon: 'fa fa-times',
                                    classname: 'btn btn-danger btn-delete btn-xs btn-ajax',
                                    extend: 'data-toggle="tooltip"',
                                    url: function (row) {
                                        return Fast.api.fixurl("famysql/table/restore?action=delete&file=" + row.file);
                                    },
                                    confirm: function (row) {
                                        return '是否确定删除该“' + row.file + '”备份文件，不可恢复？';
                                    },
                                    refresh: true
                                },
                            ],
                            formatter: Table.api.formatter.buttons
                        }
                    ]
                ],
                commonSearch: true,
                search: false,
                templateView: false,
                clickToSelect: false,
                showColumns: false,
                showToggle: false,
                showExport: false,
                showSearch: false,
                searchFormVisible: false,
                queryParams: function (params) {
                    if (Config.group) {
                        //这里可以追加搜索条件
                        var filter = JSON.parse(params.filter);
                        var op = JSON.parse(params.op);
                        filter.addon = Config.group;
                        op.addon = "=";
                        params.filter = JSON.stringify(filter);
                        params.op = JSON.stringify(op);
                    }

                    return params;
                },
            });

            // 为表格绑定事件
            Table.api.bindevent(table);

            // 切换
            $(document).on("click", ".btn-switch", function () {
                $(".btn-switch").removeClass("active");
                $(this).addClass("active");
                $("form.form-commonsearch input[name='type']").val($(this).data("type"));
                table.bootstrapTable('refresh', { url: $.fn.bootstrapTable.defaults.extend.index_url, pageNumber: 1 });
                return false;
            });
            $(document).on("click", ".nav-addon li a", function () {
                $(".nav-addon li").removeClass("active");
                $(this).parent().addClass("active");
                $("form.form-commonsearch input[name='addon']").val($(this).data("value"));
                table.bootstrapTable('refresh', { url: $.fn.bootstrapTable.defaults.extend.index_url, pageNumber: 1 });
                return false;
            });
            //上传完成后刷新
            $(".faupload").data("upload-complete", function (files) {
                if (files[0].ret.code) {
                    Toastr.success(files[0].ret.msg);
                } else {
                    Toastr.error(files[0].ret.msg);
                }
                $(".btn-refresh").trigger("click"); //刷新数据
            });
            Controller.api.bindevent();
        },
        backup: function () {
            $(document).on("change", "#c-addon", function () {
                $("#c-ignore_tables").selectPageRefresh();
            });
            $("#c-ignore_tables").data("params", function (obj) {
                //obj为SelectPage对象
                return { custom: { addon: $("#c-addon").val() } };
            });
            Controller.api.bindevent();
        },
        table_add: function () {
            $(document).on("change", "#c-charset", function () {
                $("#c-collation").selectPageRefresh();
            });
            Controller.api.bindevent();
        },
        table_batch_add: function () {
            $("#c-name").data("params", function (obj) {
                //obj为SelectPage对象
                return { custom: { addon: $("#c-addon").val() } };
            });
            Controller.api.bindevent();
        },
        table_edit: function () {
            $(document).on("change", "#c-charset", function () {
                $("#c-collation").selectPageRefresh();
            });
            Controller.api.bindevent();
        },
        api: {
            bindevent: function () {
                $("#c-collation").data("params", function (obj) {
                    //obj为SelectPage对象
                    return { custom: { charset: $("#c-charset").val() } };
                });

                $("#c-type").data("params", function (obj) {
                    //obj为SelectPage对象
                    if ($("#field-suffix").val() !== "无") {
                        return { custom: { suffix: $("#field-suffix").val() } };
                    }

                });

                Form.api.bindevent($("form[role=form]"));
            }
        }
    };
    return Controller;
});