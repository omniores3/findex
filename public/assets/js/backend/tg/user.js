define(['jquery', 'bootstrap', 'backend', 'table', 'form'], function ($, undefined, Backend, Table, Form) {

    var Controller = {
        index: function () {
            // 初始化表格参数配置
            Table.api.init({
                extend: {
                    index_url: 'tg/user/index' + location.search,
                    // 移除add/edit/del等操作
                    table: 'tg_user',
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
                        {field: 'tid', title: __('Tid'), operate: 'LIKE'},
                        {field: 'tusername', title: __('Tusername'), operate: 'LIKE',formatter:function(value,row,index){
                            return "<a href='https://t.me/"+value+"' target='_blank'>@"+value+"</a>";
                        }},
                        {field: 'tnick', title: __('Tnick'), operate: 'LIKE'},
                        {field: 'avatar', title: __('Avatar'), operate: 'LIKE', events: Table.api.events.image, formatter: Table.api.formatter.image},
                        {field: 'balance', title: __('Balance'), operate:'BETWEEN',formatter:function(value,row,index){
                                return "<span class='btn btn-info btn-xs btn-detail'>"+row.balance+" USD</span>";
                            }},
                        {field: 'frozen_balance', title: __('Frozen_balance'), operate:'BETWEEN',formatter:function(value,row,index){
                                return "<span class='btn btn-info btn-xs btn-detail'>"+row.frozen_balance+" USD</span>";
                            }},
                        {field: 'deposit', title: __('deposit'), operate:'BETWEEN',formatter:function(value,row,index){
                                return "<span class='btn btn-info btn-xs btn-detail'>"+row.deposit+" USD</span>";
                            }},
                        {field: 'lang', title: __('Lang'), operate: 'LIKE'},
                        {field: 'parent_id', title: __('Parent_id'), 
                            formatter: function(value, row, index) {
                                if (!row.parent) return '';
                                return [
                                    '<div style="line-height:1.5">',
                                    '<div><strong>' + __('Nickname') + ':</strong> ' + (row.parent.tnick || '') + '</div>',
                                    '<div><strong>' + __('TID') + ':</strong> ' + (row.parent.tid || '') + '</div>',
                                    '<div><strong>' + __('Username') + ':</strong> <a href="https://t.me/'+(row.parent.tusername || '')+'" target="_blank">@'+(row.parent.tusername || '')+'</a></div>',
                                    '<div><strong>' + __('Balance') + ':</strong> ' + (row.parent.balance || '0') + '</div>',
                                    '<div><strong>' + __('Frozen Balance') + ':</strong> ' + (row.parent.frozen_balance || '0') + '</div>',
                                    //'<button class="btn btn-info btn-xs btn-detail" onclick="viewUser('+row.parent_id+')"><i class="fa fa-eye"></i> '+__('Detail')+'</button> ',
                                    '</div>'
                                ].join('');
                            }
                        },
                        {field: 'status', title: __('Status'),formatter:function(value,row,index){
                                return [
                                    '<div class="btn-group">',
                                    '<button type="button" class="btn btn-warning btn-xs dropdown-toggle" data-toggle="dropdown">',
                                    __('' + row.status) + '<span class="caret"></span>',
                                    '</button>',
                                    '<ul class="dropdown-menu">',
                                    '<li><a href="javascript:;" class="btn-balance" onclick="setStatus('+row.id+',\'1\',\''+row.status+'\')">'+__('1')+'</a></li>',
                                    '<li><a href="javascript:;" class="btn-balance" onclick="setStatus('+row.id+',\'2\',\''+row.status+'\')">'+__('2')+'</a></li>',
                                    '<li><a href="javascript:;" class="btn-balance" onclick="setStatus('+row.id+',\'0\',\''+row.status+'\')">'+__('0')+'</a></li>',
                                    '<li><a href="javascript:;" class="btn-balance" onclick="setStatus('+row.id+',\'-1\',\''+row.status+'\')">'+__('-1')+'</a></li>',
                                    '</ul>',
                                    '</div>'
                                ].join('');
                        }},
                        {field: 'create_time', title: __('Create_time'), operate:'RANGE', addclass:'datetimerange', autocomplete:false, formatter: Table.api.formatter.datetime},
                        {field: 'operate', title: __('Operate'), 
                            formatter: function(value, row, index) {
                                return [
                                    '<button class="btn btn-info btn-xs btn-detail" onclick="viewUsers('+row.id+')"><i class="fa fa-eye"></i> '+__('Detail')+'</button> ',
                                    '<button class="btn btn-primary btn-xs btn-sendmsg" onclick="sendMessage('+row.id+')"><i class="fa fa-send"></i> '+__('Send Message')+'</button> ',
                                    '<div class="btn-group">',
                                    '<button type="button" class="btn btn-warning btn-xs dropdown-toggle" data-toggle="dropdown">',
                                    __('Balance Management')+' <span class="caret"></span>',
                                    '</button>',
                                    '<ul class="dropdown-menu">',
                                    '<li><a href="javascript:;" class="btn-balance" onclick="balanceOperation('+row.id+',\'add\')">'+__('Add Balance')+'</a></li>',
                                    '<li><a href="javascript:;" class="btn-balance" onclick="balanceOperation('+row.id+',\'reduce\')">'+__('Reduce Balance')+'</a></li>',
                                    '<li><a href="javascript:;" class="btn-balance" onclick="balanceOperation('+row.id+',\'freeze\')">'+__('Freeze Balance')+'</a></li>',
                                    '<li><a href="javascript:;" class="btn-balance" onclick="balanceOperation('+row.id+',\'unfreeze\')">'+__('Unfreeze Balance')+'</a></li>',
                                    //'<li><a href="javascript:;" class="btn-balance" onclick="balanceOperation('+row.id+',\'clear_frozen\')" >'+__('Clear Frozen')+'</a></li>',
                                    //'<li><a href="javascript:;" class="btn-balance" onclick="balanceOperation('+row.id+',\'reject_frozen\')">'+__('Reject Frozen')+'</a></li>',
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
        }
    };
    return Controller;
});

// 添加自定义按钮事件
$(document).on("click", ".btn-detail", function() {
    console.log('Detail button clicked'); // 调试输出
    var ids = Table.api.selectedIds(table);
    if (ids.length === 0) {
        Toastr.error(__('Please select at least one record'));
        return false;
    }
    layer.open({
        type: 2,
        title: __('Detail'),
        content: "{:url('tg/user/detail')}?id=" + ids[0]
    });
});



function viewUsers(id) {
    layer.open({
        type: 2,
        title: __("userinfo"),
        shadeClose: true,
        shade: 0.8,
        area: ['100%', '100%'],
        content: 'user/detail?id=' + id
    });
}

function sendMessage(id) {
    layer.open({
        type: 2,
        title: __("sendMessage"),
        shadeClose: true,
        shade: 0.8,
        area: ['800px', '600px'],
        content: 'user/sendmessage?id=' + id
    });
}

function balanceOperation(id, type) {
    let isBound = false;
    layer.prompt({
        title: __("input_amount"),
        formType: 0
    }, function(amount, index) {
        layer.prompt({
            title: __("input_text"),
            formType: 2
        }, function(remark, index2) {
            if(!isBound) {
                $.post('tg/user/balance', {
                    id: id,
                    type: type,
                    amount: amount,
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
        layer.close(index);
    });
}


function setStatus(id, type,status) {
    let isBound = false;
    if(type === status){
        layer.alert(__('Status_error'));
        return;
    }
    layer.confirm(__('Confirm_Change_Status') + __(type),{
        btn: [__('submit'),__('clone')] //按钮
    }, function(remark, index) {
        if(!isBound) {
            $.post('tg/user/setstatus', {
                id: id,
                type: type,
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