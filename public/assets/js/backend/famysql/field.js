define(['jquery', 'bootstrap', 'backend', 'table', 'form'], function ($, undefined, Backend, Table, Form) {

    var Controller = {
        fields: function () {
            // 初始化表格参数配置
            Table.config.dragsortfield = 'name';

            var name = $("#assign-data-name").val();
            var is_admin = $("#assign-data-is_admin").val();
            Table.api.init({
                extend: {
                    index_url: 'famysql/field/fields?name=' + name + '&is_admin=' + is_admin,
                    add_url: 'famysql/field/field_add?name=' + name,
                    dragsort_url: 'famysql/field/field_drag?name=' + name,
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
                        { field: 'type', title: __('Type') },
                        { field: 'length', title: __('Length') },
                        { field: 'default', title: __('Default') },
                        { field: 'is_null', title: __('Is_null') },
                        { field: 'unsigned', title: __('Unsigned') },
                        { field: 'comment', title: __('Comment') },
                        {
                            field: 'operate',
                            title: __('Table Operate'),
                            buttons: [
                                {
                                    name: 'dragsort',
                                    icon: 'fa fa-arrows',
                                    title: __('Drag to sort'),
                                    extend: 'data-toggle="tooltip"',
                                    classname: 'btn btn-xs btn-primary btn-dragsort',
                                },
                                {
                                    name: 'field_edit',
                                    icon: 'fa fa-pencil',
                                    title: __('Edit'),
                                    extend: 'data-toggle="tooltip"',
                                    url: function (row) {
                                        return Fast.api.fixurl("famysql/field/field_edit?table=" + name + "&field=" + row.name);
                                    },
                                    classname: 'btn btn-xs btn-success btn-dialog'
                                },
                                {
                                    name: 'field_del',
                                    icon: 'fa fa-trash',
                                    title: __('Del'),
                                    extend: 'data-toggle="tooltip"',
                                    url: function (row) {
                                        return Fast.api.fixurl("famysql/field/field_del?table=" + name + "&field=" + row.name);
                                    },
                                    classname: 'btn btn-xs btn-danger btn-ajax',
                                    confirm: function (row) {
                                        return '是否确定删除该“' + row.name + '”字段，不可恢复？';
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
                                if (!row.is_admin || row.name == 'id') {
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
        field_add: function () {
            Controller.api.bindevent();
            var ints = ["int", "tinyint", "smallint", "mediumint", "bigint", "float", "double", "decimal"]
            $(document).on("change", "#field-suffix", function () {
                var suffix = $(this).val();
                if (suffix !== "无") {
                    $.ajax({
                        type: "POST",
                        url: "famysql/field/getSuffix",
                        data: { name: suffix },
                        async: false
                    }).done(function (data) {
                        $("#c-type").val((data.type)[0]);
                        var type = $("#c-type").val();
                        var unsigned_show = $(".form-input-unsigned").hasClass("hidden");
                        var length_show = $(".form-input-length").hasClass("hidden");
                        var basic_show = $(".form-input-basic").hasClass("hidden");
                        var default_show = $(".form-input-default").hasClass("hidden");
                        if (ints.indexOf(type) !== -1) {
                            if (unsigned_show) {
                                $(".form-input-unsigned").removeClass("hidden");
                                $(".form-input-zerofill").removeClass("hidden");
                                $(".form-input-unsigned input").attr("disabled", false);
                                $(".form-input-zerofill input").attr("disabled", false);
                            }
                            if (!length_show) {
                                $(".form-input-length").removeClass("hidden");
                                $(".form-input-length input").attr("disabled", false);
                            }
                            if (!basic_show) {
                                $(".form-input-basic").addClass("hidden");
                                $(".form-input-basic textarea").attr("disabled", "disabled");
                            }
                            if (default_show) {
                                $(".form-input-default").removeClass("hidden");
                                $(".form-input-default input").attr("disabled", false);
                            }
                        } else if (type == 'enum' || type == 'set') {
                            if (!unsigned_show) {
                                $(".form-input-unsigned").addClass("hidden");
                                $(".form-input-zerofill").addClass("hidden");
                                $(".form-input-unsigned input").attr("disabled", "disabled");
                                $(".form-input-zerofill input").attr("disabled", "disabled");
                            }
                            if (!length_show) {
                                $(".form-input-length").addClass("hidden");
                                $(".form-input-length input").attr("disabled", "disabled");
                            }
                            if (basic_show) {
                                $(".form-input-basic").removeClass("hidden");
                                $(".form-input-basic textarea").attr("disabled", false);
                            }
                            if (default_show) {
                                $(".form-input-default").removeClass("hidden");
                                $(".form-input-default input").attr("disabled", false);
                            }
                        } else if (type == 'text' || type == 'longtext' || type == 'mediumtext') {
                            if (!unsigned_show) {
                                $(".form-input-unsigned").addClass("hidden");
                                $(".form-input-zerofill").addClass("hidden");
                                $(".form-input-unsigned input").attr("disabled", "disabled");
                                $(".form-input-zerofill input").attr("disabled", "disabled");
                            }
                            if (!length_show) {
                                $(".form-input-length").addClass("hidden");
                                $(".form-input-length input").attr("disabled", "disabled");
                            }
                            if (!basic_show) {
                                $(".form-input-basic").addClass("hidden");
                                $(".form-input-basic textarea").attr("disabled", "disabled");
                            }
                            if (!default_show) {
                                $(".form-input-default").addClass("hidden");
                                $(".form-input-default input").attr("disabled", "disabled");
                            }
                        } else if (type == 'date' || type == 'datetime' || type == 'time' || type == 'year') {
                            if (!unsigned_show) {
                                $(".form-input-unsigned").addClass("hidden");
                                $(".form-input-zerofill").addClass("hidden");
                                $(".form-input-unsigned input").attr("disabled", "disabled");
                                $(".form-input-zerofill input").attr("disabled", "disabled");
                            }
                            if (!length_show) {
                                $(".form-input-length").addClass("hidden");
                                $(".form-input-length input").attr("disabled", "disabled");
                            }
                            if (!basic_show) {
                                $(".form-input-basic").addClass("hidden");
                                $(".form-input-basic textarea").attr("disabled", "disabled");
                            }
                            if (!default_show) {
                                $(".form-input-default").addClass("hidden");
                                $(".form-input-default input").attr("disabled", "disabled");
                            }
                        } else {
                            if (!unsigned_show) {
                                $(".form-input-unsigned").addClass("hidden");
                                $(".form-input-zerofill").addClass("hidden");
                                $(".form-input-unsigned input").attr("disabled", "disabled");
                                $(".form-input-zerofill input").attr("disabled", "disabled");
                            }
                            if (length_show) {
                                $(".form-input-length").removeClass("hidden");
                                $(".form-input-length input").attr("disabled", false);
                            } else if (!length_show && !data.length) {
                                $(".form-input-length").addClass("hidden");
                                $(".form-input-length input").attr("disabled", "disabled");
                            }
                            if (!basic_show) {
                                $(".form-input-basic").addClass("hidden");
                                $(".form-input-basic textarea").attr("disabled", "disabled");
                            }
                            if (default_show) {
                                $(".form-input-default").removeClass("hidden");
                                $(".form-input-default input").attr("disabled", false);
                            }
                        }
                        $("#c-length").val(data.length);
                        $("#c-comment").val(data.comment);
                        $("#c-remark").val(data.remark);
                    })
                    $(".form-input-remark").removeClass("hidden");
                } else {
                    $("#field_add-form").trigger("reset");
                    $('#c-type').val("varchar");
                    $(".form-input-remark").addClass("hidden");
                    $(".form-input-remark input").attr("disabled", "disabled");
                    $(".form-input-length").removeClass("hidden");
                    $(".form-input-basic").addClass("hidden");
                }

                $("#c-type").selectPageRefresh();
            });
        },
        field_edit: function () {
            Controller.api.bindevent();
        },
        create: function () {
            Controller.api.bindevent();
        },
        api: {
            bindevent: function () {
                var ints = ["int", "tinyint", "smallint", "mediumint", "bigint", "float", "double", "decimal"]
                $(document).on("change", "#c-type", function () {
                    var type = $(this).val();
                    var unsigned_show = $(".form-input-unsigned").hasClass("hidden");
                    var length_show = $(".form-input-length").hasClass("hidden");
                    var basic_show = $(".form-input-basic").hasClass("hidden");
                    var default_show = $(".form-input-default").hasClass("hidden");
                    if (ints.indexOf(type) !== -1) {
                        if (unsigned_show) {
                            $(".form-input-unsigned").removeClass("hidden");
                            $(".form-input-zerofill").removeClass("hidden");
                            $(".form-input-unsigned input").attr("disabled", false);
                            $(".form-input-zerofill input").attr("disabled", false);
                        }
                        if (!length_show) {
                            $(".form-input-length").removeClass("hidden");
                            $(".form-input-length input").attr("disabled", false);
                        }
                        if (!basic_show) {
                            $(".form-input-basic").addClass("hidden");
                            $(".form-input-basic textarea").attr("disabled", "disabled");
                        }
                        if (default_show) {
                            $(".form-input-default").removeClass("hidden");
                            $(".form-input-default input").attr("disabled", false);
                        }
                    } else if (type == 'enum' || type == 'set') {
                        if (!unsigned_show) {
                            $(".form-input-unsigned").addClass("hidden");
                            $(".form-input-zerofill").addClass("hidden");
                            $(".form-input-unsigned input").attr("disabled", "disabled");
                            $(".form-input-zerofill input").attr("disabled", "disabled");
                        }
                        if (!length_show) {
                            $(".form-input-length").addClass("hidden");
                            $(".form-input-length input").attr("disabled", "disabled");
                        }
                        if (basic_show) {
                            $(".form-input-basic").removeClass("hidden");
                            $(".form-input-basic textarea").attr("disabled", false);
                        }
                        if (default_show) {
                            $(".form-input-default").removeClass("hidden");
                            $(".form-input-default input").attr("disabled", false);
                        }
                    } else if (type == 'text' || type == 'longtext' || type == 'mediumtext') {
                        if (!unsigned_show) {
                            $(".form-input-unsigned").addClass("hidden");
                            $(".form-input-zerofill").addClass("hidden");
                            $(".form-input-unsigned input").attr("disabled", "disabled");
                            $(".form-input-zerofill input").attr("disabled", "disabled");
                        }
                        if (!length_show) {
                            $(".form-input-length").addClass("hidden");
                            $(".form-input-length input").attr("disabled", "disabled");
                        }
                        if (!basic_show) {
                            $(".form-input-basic").addClass("hidden");
                            $(".form-input-basic textarea").attr("disabled", "disabled");
                        }
                        if (default_show) {
                            $(".form-input-default").removeClass("hidden");
                            $(".form-input-default input").attr("disabled", false);
                        }
                    } else if (type == 'date' || type == 'datetime' || type == 'time' || type == 'year') {
                        if (!unsigned_show) {
                            $(".form-input-unsigned").addClass("hidden");
                            $(".form-input-zerofill").addClass("hidden");
                            $(".form-input-unsigned input").attr("disabled", "disabled");
                            $(".form-input-zerofill input").attr("disabled", "disabled");
                        }
                        if (!length_show) {
                            $(".form-input-length").addClass("hidden");
                            $(".form-input-length input").attr("disabled", "disabled");
                        }
                        if (!basic_show) {
                            $(".form-input-basic").addClass("hidden");
                            $(".form-input-basic textarea").attr("disabled", "disabled");
                        }
                        if (!default_show) {
                            $(".form-input-default").addClass("hidden");
                            $(".form-input-default input").attr("disabled", "disabled");
                        }
                    } else {
                        if (!unsigned_show) {
                            $(".form-input-unsigned").addClass("hidden");
                            $(".form-input-zerofill").addClass("hidden");
                            $(".form-input-unsigned input").attr("disabled", "disabled");
                            $(".form-input-zerofill input").attr("disabled", "disabled");
                        }
                        if (length_show) {
                            $(".form-input-length").removeClass("hidden");
                            $(".form-input-length input").attr("disabled", false);
                        }
                        if (!basic_show) {
                            $(".form-input-basic").addClass("hidden");
                            $(".form-input-basic textarea").attr("disabled", "disabled");
                        }
                        if (default_show) {
                            $(".form-input-default").removeClass("hidden");
                            $(".form-input-default input").attr("disabled", false);
                        }
                    }
                    $("#c-length").val("");
                    $("#c-default").val("");
                });
                Form.api.bindevent($("form[role=form]"));
            }
        }
    };
    return Controller;
});
