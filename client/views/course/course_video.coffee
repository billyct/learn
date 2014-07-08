
Template.course_video.helpers({
    course_video : ->
        if @video?
            video = Uploads.findOne({_id : @video, type:'video'})

            if video?.server is "qiniu"
                video.path = "http://" + AppSetting.qiniu.DOMAIN + "/" + video.path;
            return video
})


Template.course_video.rendered = ->
    if @find('video')?
        videojs(@find('video'))
