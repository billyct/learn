Template.afInput_timepicker.rendered = ->
    @$('input').timepicker({ 'step': 15 })

Template.afInput_fileimage.image = ->
    if @value?
        image = Uploads.findOne({_id: @value})
        if image?.server is "qiniu"
            path = "http://" + AppSetting.qiniu.DOMAIN + "/" + image.path;
    return path
Template.afInput_fileimage.rendered = ->
    self = @
    Meteor.call "upToken", (err, result) ->
        uploader = Qiniu.uploader
            runtimes: 'html5,flash,html4'    #上传模式依次退化
            browse_button: self.find('#pickfiles')       #上传选择的点选按钮，**必需**
            #uptoken_url: '/token'            #Ajax请求upToken的Url，**必需**（服务端提供）
            uptoken : result
            domain: "http://#{AppSetting.qiniu.Bucket_Name}.qiniudn.com/"   #bucket 域名，下载资源时用到，**必需**
            container: self.find('#fileinput')           #上传区域DOM ID，默认是browser_button的父元素，
            max_file_size: '100mb'           #最大文件体积限制
            filters:
                mime_types : [
                    {title : "图片文件", extensions : "jpg,jpeg,gif,png"}
                ]
            flash_swf_url: '/assets/plupload/Moxie.swf'  #引入flash相对路径
            max_retries: 3                   #上传失败最大重试次数
            dragdrop: true                   #开启可拖曳上传
            drop_element: self.find('#fileinput')        #拖曳上传区域元素的ID，拖曳文件或文件夹后可触发上传
            chunk_size: '4mb'                #分块上传时，每片的体积
            auto_start: true                 #选择文件后自动上传，若关闭需要自己绑定事件触发上传
            init:
                'FilesAdded': (up, files) ->
                    plupload.each files, (file) ->
                        showImagePreview(file, self.$('#preview'))
                        self.$('#progress').show()
                        self.$('#help').show()
                        self.$('#help').html("开始上传..")
                        #文件添加进队列后处理相关的事情
                'BeforeUpload': (up, files) ->
                    #每个文件上传前处理相关的事情
                    image = self.$('#input-hidden').val()
                    if self.$('#input-hidden').val()
                        Meteor.call "removeUpload", image
                'UploadProgress': (up, file) ->
                    #每个文件上传时处理相关的事情
                    self.$('#progress span').html("#{file.percent}%")
                    self.$('#help').html("正在上传..")
                'FileUploaded': (up, files, info) ->
                    #每个文件上传成功后处理相关的事情
                    res = EJSON.parse(info)
                    Meteor.call "uploadImageWithPath", res.key, 'qiniu', (err, result) ->
                        self.$('#input-hidden').val(result)
                        self.$('#progress').hide()
                        self.$('#help').html("上传成功!")

                'Error': (up, err, errTip) ->
                    #上传出错时处理相关的事情
                    self.$('#help').html("上传错误..")
                    bootbox.alert errTip
                'UploadComplete': () ->
                       #队列文件处理完毕后处理相关的事情



    # I take the given File object (as presented by
    # Plupoload), and show the client-side-only preview of
    # the selected image object.
    showImagePreview = ( file , item) ->
        item.find('img').remove()
        image = $( new Image() ).prependTo( item )
        # Create an instance of the mOxie Image object. This
        # utility object provides several means of reading in
        # and loading image data from various sources.
        # --
        # Wiki: https:#github.com/moxiecode/moxie/wiki/Image
        preloader = new mOxie.Image()
        # Define the onload BEFORE you execute the load()
        # command as load() does not execute async.
        preloader.onload = ->
            # This will scale the image (in memory) before it
            # tries to render it. This just reduces the amount
            # of Base64 data that needs to be rendered.
            preloader.downsize( 300, 300 )
            # Now that the image is preloaded, grab the Base64
            # encoded data URL. This will show the image
            # without making an Network request using the
            # client-side file binary.
            image.prop( "src", preloader.getAsDataURL() )
            # NOTE: These previews "work" in the FLASH runtime.
            # But, they look seriously junky-to-the-monkey.
            # Looks like they are only using like 256 colors.
        # Calling the .getSource() on the file will return an
        # instance of mOxie.File, which is a unified file
        # wrapper that can be used across the various runtimes.
        # --
        # Wiki: https:#github.com/moxiecode/plupload/wiki/File
        preloader.load( file.getSource() );

Template.afInput_filemedia.events
    "click #button-upload" : (e, tpl) ->
        $(e.currentTarget).hide()
        tpl.$('#button-cancel').show()
        tpl.uploader.start()
    "click #button-cancel" : (e, tpl) ->
        bootbox.confirm "确定取消?", (result) ->
            if result
                self.$('#preview span').hide()
                $(e.currentTarget).hide()
                tpl.$('#button-upload').show()
                progressbar = tpl.$('#progressbar')
                # progressbar.attr("aria-valuenow", 0)
                progressbar.css("width", "0%")
                tpl.$('.btn-group').hide()
                self.$('#preview span').html('')
                tpl.$('.progress').hide()
                tpl.$('#help').hide()
                tpl.uploader.stop()

Template.afInput_filemedia.media = ->
    if @value?
        media = Uploads.findOne({_id: @value})
    return media

Template.afInput_filemedia.rendered = ->
    type = @data.atts['dataType']
    self = @
    Meteor.call "upToken", type, (err, result) ->
        self.uploader = Qiniu.uploader
            runtimes: 'html5,flash,html4'    #上传模式依次退化
            browse_button: self.find('#pickfiles')       #上传选择的点选按钮，**必需**
            # uptoken_url: '/token'            #Ajax请求upToken的Url，**必需**（服务端提供）
            uptoken : result
            domain: "http://#{AppSetting.qiniu.Bucket_Name}.qiniudn.com/"   #bucket 域名，下载资源时用到，**必需**
            container: self.find('#fileinput')           #上传区域DOM ID，默认是browser_button的父元素，
            max_file_size: '100mb'           #最大文件体积限制
            filters:
                mime_types : [
                    {title : "视频文件", extensions : "avi,mp4,rvmb,webm,mov,m4v"}
                    {title : "音频文件", extensions : "wav,mp3,ogg"}
                ]
            flash_swf_url: '/assets/plupload/Moxie.swf'  #引入flash相对路径
            max_retries: 3                   #上传失败最大重试次数
            dragdrop: true                   #开启可拖曳上传
            drop_element: self.find('#fileinput')        #拖曳上传区域元素的ID，拖曳文件或文件夹后可触发上传
            chunk_size: '4mb'                #分块上传时，每片的体积
            auto_start: false                 #选择文件后自动上传，若关闭需要自己绑定事件触发上传
            init:
                'FilesAdded': (up, files) ->
                    plupload.each files, (file) ->
                        # showImagePreview(file, self.$('#preview'))
                        self.$('.btn-group').show()
                        self.$('#preview span').show()
                        self.$('#preview span').html(file.name)
                        self.$('.progress').show()
                        self.$('#help').show()
                        self.$('#help').html("开始上传..")
                        #文件添加进队列后处理相关的事情
                'BeforeUpload': (up, files) ->
                    #每个文件上传前处理相关的事情
                    media = self.$('#input-hidden').val()
                    if self.$('#input-hidden').val()
                        Meteor.call "removeUpload", media
                'UploadProgress': (up, file) ->
                    #每个文件上传时处理相关的事情
                    progressbar = self.$('#progressbar')
                    # progressbar.attr("aria-valuenow", file.percent)
                    progressbar.css("width", "#{file.percent}%")
                    formatSpeed = plupload.formatSize(up.total.bytesPerSec).toUpperCase();
                    progressbar.html("#{file.percent}% - #{formatSpeed}/s")
                    self.$('#help').html("正在上传..")
                'FileUploaded': (up, files, info) ->
                    #每个文件上传成功后处理相关的事情
                    res = EJSON.parse(info)
                    Meteor.call "uploadVideoWithPath", res.key, 'qiniu', res.persistentId, (err, result) ->
                        self.$('#input-hidden').val(result)
                        self.$('.progress').hide()
                        self.$('#help').html("上传成功!")
                        self.$('#help').hide()
                        self.$('.btn-group').hide()

                'Error': (up, err, errTip) ->
                    #上传出错时处理相关的事情
                    self.$('#help').html("上传错误..")
                    bootbox.alert errTip
                'UploadComplete': () ->
                       #队列文件处理完毕后处理相关的事情
