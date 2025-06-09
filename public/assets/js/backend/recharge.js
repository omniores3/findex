define(['jquery', 'bootstrap', 'backend', 'table', 'form'], function ($, undefined, Backend, Table, Form) {

    var Controller = {
        index: function () {
            // 初始化表格参数配置
            Table.api.init({
                extend: {
                    index_url: 'recharge/index' + location.search,
                    add_url: 'recharge/add',
                    edit_url: 'recharge/edit',
                    del_url: 'recharge/del',
                    multi_url: 'recharge/multi',
                    import_url: 'recharge/import',
                    table: 'recharge',
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
                        {field: 'orderid', title: __('Orderid'), operate: 'LIKE'},
                        {field: 'ordersn', title: __('Ordersn'), operate: 'LIKE'},
                        {field: 'user_id', title: __('User_id'),formatter:function(value,row,index){
                                return row.tg_user.tnick + "(<a href='https://t.me/"+row.tg_user.tusername+"' target='_blank'>"+row.tg_user.tusername+"</a>)";
                            }},
                        {field: 'amount', title: __('Amount'), operate:'BETWEEN'},
                        {field: 'money', title: __('Money'), operate:'BETWEEN'},
                        {field: 'basecurrency', title: __('Basecurrency'), operate:'BETWEEN'},
                        {field: 'addressqr', title: __('Addressqr'), operate:'BETWEEN',formatter:function(value,row,index){
                                return "<a href='"+row.addressqr+"' target='_blank'><img src='"+row.addressqr+"' width='100px' height='100px'/></a>";
                            }},
                        {field: 'toaddress', title: __('Toaddress'), operate:'BETWEEN',formatter:function(value,row,index){
                                if(row.toaddress){
                                    return "<a href='https://tronscan.io/#/address/"+row.toaddress+"' target='_blank'>" + row.toaddress +"</a>";
                                }else{
                                    return "";
                                }
                            }},
                        {field: 'currency', title: __('Currency'), operate: 'LIKE'},
                        {field: 'sign', title: __('Sign'), operate: 'LIKE'},
                        {field: 'pass_through_info', title: __('Pass_through_info'), operate: 'LIKE', table: table, class: 'autocontent',formatter:function(value,row,index){
                                if(row.pass_through_info){
                                    return "<a href='https://tronscan.io/#/address/"+row.pass_through_info+"' target='_blank'>" + row.pass_through_info +"</a>";
                                }else{
                                    return "";
                                }
                            }},
                        {field: 'status', title: __('Status'), searchList: {"-2":__('Status -2'),"-1":__('Status -1'),"0":__('Status 0'),"1":__('Status 1')}, formatter: Table.api.formatter.status},
                        {field: 'block', title: __('Block'), operate: 'LIKE', table: table, class: 'autocontent',formatter:function(value,row,index){
                                if(row.block){
                                    return "<a href='https://tronscan.io/#/transaction/"+row.block+"' target='_blank'>" + row.block +"</a>";
                                }else{
                                    return "";
                                }
                            }},
                        {field: 'createtime', title: __('Createtime'), operate:'RANGE', addclass:'datetimerange', autocomplete:false, formatter: Table.api.formatter.datetime},
                        {field: 'paytime', title: __('Paytime'), operate:'RANGE', addclass:'datetimerange', autocomplete:false, formatter: Table.api.formatter.datetime},
                        {field: 'operate', title: __('Operate'), table: table, events: Table.api.events.operate,
                            formatter: function(value, row, index) {
                                return [
                                    '<button class="btn btn-info btn-xs btn-detail" onclick="viewUser(' + row.id + ')"><i class="fa fa-eye"></i> ' + __('Detail') + '</button> ',
                                    '<div class="btn-group">',
                                    '<button type="button" class="btn btn-warning btn-xs dropdown-toggle" data-toggle="dropdown">',
                                    __('Order_action')+' <span class="caret"></span>',
                                    '</button>',
                                    '<ul class="dropdown-menu">',
                                    '<li><a href="javascript:;" class="btn-balance" onclick="setOrderSuccess('+row.id+','+row.status+')">'+__('Make up the order')+'</a></li>',
                                    '<li><a href="javascript:;" class="btn-balance" onclick="Revocation('+row.id+','+row.status+')">'+__('Revocation')+'</a></li>',
                                    '</ul>',
                                    '</div>'
                                ].join('');
                            }
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
//设置订单已支付
function setOrderSuccess(id,status){
    if("1" === status){
        layer.alert(__('Status_error'));
        return;
    }
    let isBound = false;
    layer.confirm(__('Confirm_Change_Status'),{
        btn: [__('submit'),__('clone')] //按钮
    }, function(remark, index) {
        if(!isBound) {
            $.post('recharge/setsuccess', {
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


function viewUser(id) {
    layer.open({
        type: 2,
        title: __("rechargeinfo"),
        shadeClose: true,
        shade: 0.8,
        area: ['100%', '100%'],
        content: 'recharge/detail?id=' + id
    });
}

//撤销已支付订单
function Revocation(id,status){

    if("1" != status){
        layer.alert(__('Status_error'));
        return;
    }
    let isBound = false;
    layer.confirm(__('Confirm_Change_Status'),{
        btn: [__('submit'),__('clone')] //按钮
    }, function(remark, index) {
        if(!isBound) {
            $.post('recharge/revocation', {
                id: id,
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