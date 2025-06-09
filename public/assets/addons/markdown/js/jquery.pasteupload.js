// https://github.com/yuezhongxin/paste-upload-image.js

(function ($) {
    var isImage, isImageForDrop, getFilename, getMimeType;
    isImage = function (data) {
        var i, item;
        i = 0;
        while (i < data.clipboardData.items.length) {
            item = data.clipboardData.items[i];
            if (item.type.indexOf("image") !== -1) {
                return item;
            }
            i++;
        }
        return false;
    };
    isImageForDrop = function (data) {
        var i, item;
        i = 0;
        while (i < data.dataTransfer.files.length) {
            item = data.dataTransfer.files[i];
            if (item.type.indexOf("image") !== -1) {
                return item;
            }
            i++;
        }
        return false;
    };
    getFilename = function (e) {
        var value;
        if (window.clipboardData && window.clipboardData.getData) {
            value = window.clipboardData.getData("Text");
        } else if (e.clipboardData && e.clipboardData.getData) {
            value = e.clipboardData.getData("text/plain");
        }
        value = value.split("\r");
        return value[0];
    };
    getMimeType = function (file, filename) {
        var mimeType = file.type;
        var extendName = filename.substring(filename.lastIndexOf('.') + 1);
        if (mimeType != 'image/' + extendName) {
            return 'image/' + extendName;
        }
        return mimeType;
    };
    $.fn.pasteUploadImage = function (options) {
        options = $.extend({}, $.fn.pasteUploadImage.defaults, options, {fileType: 'image'});
        return this.each(function () {
            var that = $(this);
            that.on('paste', function (event) {
                var filename, image, pasteEvent;
                pasteEvent = event.originalEvent;
                if (pasteEvent.clipboardData && pasteEvent.clipboardData.items) {
                    image = isImage(pasteEvent);
                    if (image) {
                        event.preventDefault();
                        filename = getFilename(pasteEvent) || options.defaultImageName;
                        return that.uploadFile(image.getAsFile(), filename, options);
                    }
                }
            });
            that.on('drop', function (event) {
                var filename, image, pasteEvent;
                pasteEvent = event.originalEvent;
                if (pasteEvent.dataTransfer && pasteEvent.dataTransfer.files) {
                    image = isImageForDrop(pasteEvent);
                    if (image) {
                        event.preventDefault();
                        filename = pasteEvent.dataTransfer.files[0].name || options.defaultImageName;
                        return that.uploadFile(image, filename, options);
                    }
                }
            });
        });
    };
    $.fn.insertToTextArea = function (filename, url) {
        var options = $(this).data("pu-options") || $.fn.pasteUploadImage.defaults;
        return $(this).val(function (index, val) {
            return val.replace("{{" + filename + "(" + options.uploadingText + ")}}", (options.fileType == 'image' ? '!' : '') + "[" + (filename.match(/^[a-zA-Z0-9_\u4e00-\u9fa5\.\-]+$/) ? filename : url.substring(url.lastIndexOf('/') + 1)) + "](" + url + ")" + "\n");
        });
    };
    $.fn.removeLoadingText = function (filename) {
        var options = $(this).data("pu-options") || $.fn.pasteUploadImage.defaults;
        return $(this).val(function (index, val) {
            return val.replace("{{" + filename + "(" + options.uploadingText + ")}}", "\n");
        });
    };
    $.fn.uploadFile = function (file, filename, options) {
        var that = $(this);
        var options = $.extend(true, {}, $.fn.pasteUploadImage.defaults, options || {});
        that.data("pu-options", options);

        var text = "{{" + filename + "(" + options.uploadingText + ")}}";
        that.pasteText(text);
        var formData = new FormData();
        formData.append(options.fileName, file);
        if (options.appendMimetype) {
            formData.append("mimeType", getMimeType(file, filename));
        }

        var ajaxOptions = {
            url: '',
            data: formData,
            type: 'post',
            processData: false,
            contentType: false,
            dataType: 'json',
            success: function (data) {
                if (typeof options.success == 'function') {
                    if (false === options.success.apply(that, [data, filename, file])) {
                        return;
                    }
                }
                if (data.success) {
                    return that.insertToTextArea(filename, data.message, options);
                }
                return that.removeLoadingText(filename);
            },
            error: function (xOptions, textStatus) {
                if (typeof options.error == 'function') {
                    if (false === options.error.apply(that, [{}, filename, file])) {
                        return;
                    }
                }
                that.removeLoadingText("");
            }
        };
        if (typeof options.ajaxOptions === 'object') {
            ajaxOptions = $.extend(true, ajaxOptions, options.ajaxOptions);
        } else {
            ajaxOptions.url = options.ajaxOptions;
        }
        $.ajax(ajaxOptions);
    };

    $.fn.pasteText = function (text) {
        var that = $(this);
        var afterSelection, beforeSelection, caretEnd, caretStart, textEnd;
        caretStart = that[0].selectionStart;
        caretEnd = that[0].selectionEnd;
        textEnd = that.val().length;
        beforeSelection = that.val().substring(0, caretStart);
        afterSelection = that.val().substring(caretEnd, textEnd);
        that.val(beforeSelection + text + afterSelection);
        that.get(0).setSelectionRange(caretStart + text.length, caretEnd + text.length);
        return that.trigger("input");
    };
    $.fn.pasteUploadImage.defaults = {
        success: null,
        error: null,
        ajaxOptions: '',
        fileName: 'imageFile',
        appendMimetype: true,
        defaultImageName: 'image.png',
        uploadingText: 'uploading...',
    };

})(jQuery);
