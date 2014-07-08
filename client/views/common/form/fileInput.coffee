Template.fileInput.rendered = ->
    self = @
    Meteor.call "upToken", (err, result) ->
        uploader = Qiniu.uploader
            runtimes: 'html5,flash,html4'    #上传模式依次退化
            browse_button: self.find('#pickfiles')       #上传选择的点选按钮，**必需**
            #uptoken_url: '/token'            #Ajax请求upToken的Url，**必需**（服务端提供）
            uptoken : result
            domain: 'http://qiniu-plupload.qiniudn.com/'   #bucket 域名，下载资源时用到，**必需**
            container: self.find('#fileinput')           #上传区域DOM ID，默认是browser_button的父元素，
            max_file_size: '100mb'           #最大文件体积限制
            flash_swf_url: '/assets/plupload/Moxie.swf'  #引入flash相对路径
            max_retries: 3                   #上传失败最大重试次数
            dragdrop: true                   #开启可拖曳上传
            drop_element: self.find('#fileinput')        #拖曳上传区域元素的ID，拖曳文件或文件夹后可触发上传
            chunk_size: '4mb'                #分块上传时，每片的体积
            auto_start: false                 #选择文件后自动上传，若关闭需要自己绑定事件触发上传
            init:
                'FilesAdded': (up, files) ->
                    # self.$('table').show();
                    # self.$('#success').hide();
                    # plupload.each(files, function(file) {
                    #     var progress = new FileProgress(file, 'fsUploadProgress');
                    #     progress.setStatus("等待...");
                    # });
                    plupload.each files, (file) ->
                        showImagePreview(file, self.$('#preview'))
                        #文件添加进队列后处理相关的事情
                'BeforeUpload': (up, files) ->
                    #每个文件上传前处理相关的事情
                    chunk_size = plupload.parseSize(@getOption('chunk_size'))
                    console.log chunk_size
                'UploadProgress': (up, file) ->
                    #每个文件上传时处理相关的事情
                'FileUploaded': (up, files, info) ->
                       #每个文件上传成功后处理相关的事情
                       #其中 info 是文件上传成功后，服务端返回的json，形式如
                       # {
                       #    "hash": "Fh8xVqod2MQ1mocfI4S4KpRL6D98"
                       #    "key": "gogopher.jpg"
                       #  }
                       # 参考http:#developer.qiniu.com/docs/v6/api/overview/up/response/simple-response.html

                       # var domain = up.getOption('domain');
                       # var res = parseJSON(info);
                       # var sourceLink = domain + res.key; 获取上传成功后的文件的Url
                'Error': (up, err, errTip) ->
                    #上传出错时处理相关的事情
                    bootbox.alert errTip
                'UploadComplete': () ->
                       #队列文件处理完毕后处理相关的事情



    # I take the given File object (as presented by
    # Plupoload), and show the client-side-only preview of
    # the selected image object.
    showImagePreview = ( file , item) ->
        image = $( new Image() ).appendTo( item )
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
