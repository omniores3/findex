define(['jquery', 'bootstrap', 'backend', 'table', 'form'], function ($, undefined, Backend, Table, Form) {

    var Controller = {
        index: function () {
            // 初始化表格参数配置
            Table.api.init({
                extend: {
                    index_url: 'advorder/index' + location.search,
                    add_url: 'advorder/add',
                    edit_url: 'advorder/edit',
                    del_url: 'advorder/del',
                    multi_url: 'advorder/multi',
                    import_url: 'advorder/import',
                    table: 'advorder',
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
                        {field: 'user_id', title: __('UserId'),formatter:function(value,row,index){
                                return row.tg_user.tnick + "(<a href='https://t.me/"+ row.tg_user.tusername + "'target='_blank'>" + row.tg_user.tusername +"</a>)";
                            }},
                        {field: 'advorderid', title: __('Advorderid'), operate: 'LIKE'},
                        {field: 'advtype', title: __('Advtype'),formatter:function(value,row,index){
                                return "<span class='btn btn-info btn-xs btn-detail'>"+ __("advtype_lang")[row.advtype] +"</span>";
                            }},
                        {field: 'amount', title: __('Amount'), operate:'BETWEEN',formatter:function(value,row,index){
                                return "<span class='btn btn-info btn-xs btn-detail'>"+row.amount+" USD</span>";
                            }},
                        {field: 'buytime', title: __('Buytime'), operate: 'LIKE',formatter:function(value,row,index){
                                return "<span class='btn btn-info btn-xs btn-detail'>"+row.buytime+ __('yues') +" </span>";
                            }},
                        {field: 'paytype', title: __('Paytype'), operate: 'LIKE', table: table, class: 'autocontent', formatter:function(value,row,index){
                                return "<span class='btn btn-info btn-xs btn-detail'>"+__('pay_type_lang')[row.paytype] +" </span>";
                        }},
                        {field: 'createtime', title: __('Createtime'), operate: 'LIKE',formatter: Table.api.formatter.datetime},
                        {field: 'paytime', title: __('Paytime'), operate: 'LIKE',formatter: Table.api.formatter.datetime},
                        {field: 'operate', title: __('Operate'), table: table, events: Table.api.events.operate, formatter: function(value, row, index) {
                                return [
                                    '<button class="btn btn-info btn-xs btn-detail" onclick="viewOrders('+row.id+')"><i class="fa fa-eye"></i> '+__('Detail')+'</button> ',

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
function viewOrders(id) {
    layer.open({
        type: 2,
        title: __("viewOrders"),
        shadeClose: true,
        shade: 0.8,
        area: ['100%', '100%'],
        content: 'advorder/detail?id=' + id
    });
}