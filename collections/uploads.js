
Upload = function(document) {
    _.extend(this, document);
}

Upload.prototype = {
    constructor : Upload
}

Uploads = new Meteor.Collection('uploads', {
    transform: function(document) {
        return new Upload(document);
    }
})



Uploads.allow({
    insert: function(userId, doc) {
        if(userId) {
            return true;
        }
        return false;
    },
    update : function(userId, doc, fieldNames, modifier) {
        if(userId == doc.user) {
            return true;
        }

        return false;
    },
    remove : function(userId, doc) {
        if(userId == doc.user) {
            return true;
        }

        return false;
    }
});


if(Meteor.isServer) {

    var qiniu = Meteor.require('qiniu');

    qiniu.conf.ACCESS_KEY = AppSetting.qiniu.ACCESS_KEY;
    qiniu.conf.SECRET_KEY = AppSetting.qiniu.SECRET_KEY;


    function getUrl(domain, key) {
        var baseUrl = qiniu.rs.makeBaseUrl(domain, key);
        var policy = new qiniu.rs.GetPolicy();
        return policy.makeRequest(baseUrl);
    }




    Meteor.methods({

        removeUpload : function(_id) {
            var file = Uploads.findOne({_id : _id});
            if(!_.isUndefined(file)) {
                if (file.server === "qiniu") {
                    var client = new qiniu.rs.Client();
                    client.remove(AppSetting.qiniu.Bucket_Name, file.path, function(err, ret) {
                        if(err) {
                            throw new Meteor.Error(404, "删除文件失败！");
                        }
                    });
                }

                return Uploads.remove({_id : _id}, function(err, result) {
                    if (err) {
                        throw new Meteor.Error(404, "删除文件失败！");
                    }
                });
            }
            return;
        },

        upToken : function() {

            var type = arguments[0] ? arguments[0] : "text";

            var uptoken,token;

            var video_ops = [
                {type: "ogg", ops: "avthumb/ogg"},
                {type: "mp4", ops: "avthumb/mp4"},
                {type: "webm", ops: "avthumb/webm"}
            ];

            var audio_ops = [
                {type: "ogg", ops: "avthumb/ogg"},
                {type: "wav", ops: "avthumb/wav"},
                {type: "mp3", ops: "avthumb/mp3"}
            ];


            if(type === "text" || type == null) {
                uptoken = new qiniu.rs.PutPolicy(AppSetting.qiniu.Bucket_Name);
                token = uptoken.token();
            } else if(type === "video") {
                var ops = _.pluck(video_ops, "ops");
                ops = ops.join(";");
                uptoken = new qiniu.rs.PutPolicy(AppSetting.qiniu.Bucket_Name);
                uptoken.persistentOps = ops;
                uptoken.persistentNotifyUrl = "localhost";
                token = uptoken.token();
            } else if (type === "audio") {
                var ops = _.pluck(audio_ops, "ops");
                ops = ops.join(";");
                uptoken = new qiniu.rs.PutPolicy(AppSetting.qiniu.Bucket_Name);
                uptoken.persistentOps = ops;
                uptoken.persistentNotifyUrl = "localhost";
                token = uptoken.token();
            }

            return token;
        },


        upTokenVideo : function() {
            var ops = _.pluck(AppSetting.qiniu.Video_Ops, "ops");
            ops = ops.join(";");
            var uptoken = new qiniu.rs.PutPolicy(AppSetting.qiniu.Bucket_Name);
            uptoken.persistentOps = ops;
            uptoken.persistentNotifyUrl = "localhost";
            var token = uptoken.token();
            return token;
        },

        persistentSuccess : function(video) {
            return Uploads.update({_id: video._id}, {$unset:{persistentId: ""}})
        },

        uploadImageWithPath : function(path, server) {
            return Uploads.insert({
                path : path,
                type : 'image',
                name : path,
                server : server
            }, function(err, result) {
                if(err) {
                    throw new Meteor.Error(404, "存储图片失败！");
                }
                return result;
            })
        },

        uploadVideoWithPath : function(path, server, persistentId) {
            return Uploads.insert({
                path : path,
                type : 'video',
                name : path,
                server : server,
                persistentId : persistentId //转码标记
            }, function(err, result) {
                if(err) {
                    throw new Meteor.Error(404, "存储视频失败！");
                }
                return result;
            })
        },

        uploadWithPath : function(path, type, server) {
            return Uploads.insert({
                path : path,
                type : type,
                name : path,
                server : server
            }, function(err, result) {
                if(err) {
                    throw new Meteor.Error(404, "存储文件失败！");
                }
                return result;
            })
        }
    });
}
