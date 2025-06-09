define([], function () {
    require.config({
    paths: {
        'bootstrap-markdown': '../addons/markdown/js/bootstrap-markdown.min',
        'hyperdown': '../addons/markdown/js/hyperdown.min',
        'turndown': '../addons/markdown/js/turndown',
    },
    shim: {
        'bootstrap-markdown': {
            deps: [
                'jquery',
                'css!../addons/markdown/css/bootstrap-markdown.css'
            ],
            exports: '$.fn.markdown'
        }
    }
});
require(['form', 'upload'], function (Form, Upload) {
    var _bindevent = Form.events.bindevent;
    Form.events.bindevent = function (form) {
        _bindevent.apply(this, [form]);
        var insert = function (e, url, type) {
            var urlArr = url.split(/\,/);
            $.each(urlArr, function () {
                var url = Fast.api.cdnurl(this, true);
                if (type && type == 'image') {
                    e.replaceSelection("\n" + '![输入图片说明](' + url + ')');
                } else {
                    e.replaceSelection("\n" + '[输入链接说明](' + url + ')');
                }
            });
            e.change(e);
            // e.$element.blur();
            // e.$element.focus();
        };
        try {
            if ($(Config.markdown.classname || '.editor', form).length > 0) {
                require(['bootstrap-markdown', 'hyperdown', 'turndown'], function (undefined, undefined, Turndown) {
                    $.fn.markdown.messages.zh = {
                        Bold: "粗体",
                        Italic: "斜体",
                        Heading: "标题",
                        "URL/Link": "链接",
                        Image: "图片",
                        List: "列表",
                        "Unordered List": "无序列表",
                        "Ordered List": "有序列表",
                        Code: "代码",
                        Quote: "引用",
                        Preview: "预览",
                        "strong text": "粗体",
                        "emphasized text": "强调",
                        "heading text": "标题",
                        "enter link description here": "输入链接说明",
                        "Insert Hyperlink": "URL地址",
                        "enter image description here": "输入图片说明",
                        "Insert Image Hyperlink": "图片URL地址",
                        "enter image title here": "在这里输入图片标题",
                        "list text here": "这里是列表文本",
                        "code text here": "这里输入代码",
                        "quote here": "这里输入引用文本"
                    };
                    var parser = new HyperDown();
                    window.marked = function (text) {
                        return parser.makeHtml(text);
                    };
                    var uploadFiles;
                    uploadFiles = async function (files) {
                        var self = this;
                        for (var i = 0; i < files.length; i++) {
                            try {
                                await new Promise((resolve) => {
                                    var url, html, file;
                                    file = files[i];
                                    Upload.api.send(file, function (data) {
                                        url = Fast.api.cdnurl(data.url, true);
                                        if (file.type.indexOf("image") !== -1) {
                                            insert(self, url, 'image');
                                        } else {
                                            insert(self, url, 'file');
                                        }
                                        resolve();
                                    }, function () {
                                        resolve();
                                    });
                                });
                            } catch (e) {

                            }
                        }
                    };

                    $(Config.markdown.classname || '.editor', form).each(function () {
                        var options = $(this).data("markdown-options") || {};
                        var editor = $(this);
                        var format = typeof options.format !== 'undefined' ? options.format : Config.markdown.format;
                        if (format === 'html') {
                            var origin = editor;
                            var turndownService = new TurndownService();
                            turndownService.use(turndownPluginGfm.gfm);
                            var content = turndownService.turndown(origin.val());

                            editor = origin.clone().removeAttr("name").removeAttr("id").val(content);
                            origin.css("display", "none");
                            editor.data("markdown-origin", origin);
                            editor.insertAfter(origin);
                        }
                        (function (editor) {
                            editor.markdown($.extend(true, {
                                resize: 'vertical',
                                language: 'zh',
                                iconlibrary: 'fa',
                                autofocus: false,
                                savable: false,
                                additionalButtons: [
                                    [{
                                        name: "groupCustom",
                                        data: [{
                                            name: "cmdUploadImage",
                                            toggle: false,
                                            title: "Upload image",
                                            icon: "fa fa-upload",
                                        }, {
                                            name: "cmdUploadFile",
                                            toggle: false,
                                            title: "Upload file",
                                            icon: "fa fa-cloud-upload",
                                        }, {
                                            name: "cmdSelectImage",
                                            toggle: false,
                                            title: "Select image",
                                            icon: "fa fa-file-image-o",
                                            callback: function (e) {
                                                parent.Fast.api.open("general/attachment/select?element_id=&multiple=true&mimetype=image/*", __('Choose'), {
                                                    callback: function (data) {
                                                        var urlArr = data.url.split(/\,/);
                                                        insert(e, data.url, 'image');
                                                    }
                                                });
                                                return false;
                                            }
                                        }, {
                                            name: "cmdSelectAttachment",
                                            toggle: false,
                                            title: "Select file",
                                            icon: "fa fa-file",
                                            callback: function (e) {
                                                parent.Fast.api.open("general/attachment/select?element_id=&multiple=true&mimetype=*", __('Choose'), {
                                                    callback: function (data) {
                                                        insert(e, data.url, 'file');
                                                    }
                                                });
                                                return false;
                                            }
                                        }]
                                    }]
                                ],
                                onShow: function (e) {
                                    //添加上传图片按钮和上传附件按钮
                                    var imgBtn = $("button[data-handler='bootstrap-markdown-cmdUploadImage']", e.$editor);
                                    var fileBtn = $("button[data-handler='bootstrap-markdown-cmdUploadFile']", e.$editor);
                                    var btnParent = imgBtn.parent();
                                    btnParent.addClass("md-relative");

                                    var upImgBtn = $('<button type="button" class="uploadimage faupload" data-button="image" title="点击上传图片" data-mimetype="image/gif,image/jpeg,image/png,image/jpg,image/bmp,image/webp" data-multiple="true">点击上传图片</button>');
                                    upImgBtn.css(imgBtn.position()).appendTo(btnParent);

                                    var upFileBtn = $('<button type="button" class="uploadfile faupload" data-button="file" title="点击上传附件" data-multiple="true">点击上传附件</button>');
                                    upFileBtn.css(fileBtn.position()).appendTo(btnParent);

                                    upImgBtn.data("upload-success", function (data, ret) {
                                        insert(e, data.url, 'image');
                                    });
                                    upFileBtn.data("upload-success", function (data, ret) {
                                        insert(e, data.url, 'file');
                                    });
                                    Form.events.faupload(e.$editor);

                                    $(".uploadimage,.uploadfile", e.$editor).on("mouseenter", function () {
                                        ($(this).data("button") === 'image' ? imgBtn : fileBtn).addClass("active");
                                    }).on("mouseleave", function () {
                                        ($(this).data("button") === 'image' ? imgBtn : fileBtn).removeClass("active");
                                    });

                                    //粘贴上传
                                    $(e.$textarea).bind('paste', function (event) {
                                        var originalEvent;
                                        originalEvent = event.originalEvent;
                                        if (originalEvent.clipboardData && originalEvent.clipboardData.files.length > 0) {
                                            uploadFiles.call(e, originalEvent.clipboardData.files);
                                            return false;
                                        }
                                    });
                                    //拖拽上传
                                    $(e.$textarea).bind('drop', function (event) {
                                        var originalEvent;
                                        originalEvent = event.originalEvent;
                                        if (originalEvent.dataTransfer && originalEvent.dataTransfer.files.length > 0) {
                                            uploadFiles.call(e, originalEvent.dataTransfer.files);
                                            return false;
                                        }
                                    });
                                },
                                onChange: function (e) {
                                    var origin = $(e.$textarea).data("markdown-origin");
                                    if (origin) {
                                        origin.val(marked(e.$textarea.val()));
                                    }
                                }
                            }, editor.data("markdown-options") || {}));
                        })(editor)
                    });
                });
            }
        } catch (e) {
            console.log(e);
        }

    };
});

});