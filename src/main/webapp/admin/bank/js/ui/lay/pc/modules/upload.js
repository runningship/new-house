/** layui-v0.0.2 跨设备模块化前端框架@LGPL http://www.layui.com/ By 贤心 */
;layui.define("jquery",function(a){var e=layui.jquery;a("upload",function(a){a=a||{};var n=e("body"),i=navigator.userAgent.toLowerCase().match(/msie\s(\d+)/)||[],t="layui-iframe-"+Math.floor(100*Math.random()),o=e(a.file||".layui-upload-file"),s=e('<iframe class="layui-upload-iframe" name="'+t+'"></iframe>'),r=e('<form target="'+t+'" method="'+(a.methid||"post")+'" key="set-mine" enctype="multipart/form-data" action="'+(a.url||"")+'"></form>');o.after('<span class="layui-upload-icon"><i class="layui-icon">&#xe608;</i>上传图片</span>'),n.append(s),o.wrap(r),e(".layui-upload-iframe")[0]||n.append(s),o.off("change").on("change",function(){var n=e(this),t=n.val();if(/\w\.(jpg|png|gif|bmp)$/.test(escape(t)))if(o.parent().submit(),a.before&&a.before(),i&&i[1]<10)var r=setInterval(function(){var e=conf.iframe.contents().find("body").html();clearInterval(r),"function"==typeof a.success&&a.success(e)},100);else s[0].onload=function(){var e=s.contents().find("body").html();"function"==typeof a.success&&a.success(e)};else layer.msg("图片格式不对"),n.val("");n.val("")})})});