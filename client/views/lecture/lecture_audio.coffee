Template.lecture_audio.helpers({
    audio : ->
        if @audio?
            audio = Uploads.findOne(@audio)

            if audio?.server is "qiniu"
                audio.path = "http://" + AppSetting.qiniu.DOMAIN + "/" + audio.path;
            return audio
})
