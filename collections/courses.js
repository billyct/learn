Course = function(document) {
    _.extend(this, document);
}

Course.prototype = {
    constructor : Course,

    sections : function() {
        return Sections.find({course: this._id}, {sort:{order:1}}).map(function(doc, index, cursor) {
            return _.extend(doc, {index: index + 1});
        });
    },

    poster : function() {
        var image = Uploads.findOne({_id: this.image});
        if (!_.isUndefined(image) && image.server === "qiniu") {
            image.path = "http://" + AppSetting.qiniu.DOMAIN + "/" + image.path;
        }

        return image;
    },

    teacher : function() {
        return Meteor.users.findOne({_id: this.author}, {fields: {profile : 1}})
    },

    lectures : function() {
        return Lectures.find({course:this._id},{sort: {order: 1}}).fetch();
    },

    lecture_count : function() {
        return Lectures.find({course: this._id}).count();
    },
    
    time_count : function() {
        var times = _.pluck(this.lectures(), 'time');
        var timeTotal = 0;

        for(var i = 0; i < times.length; i++) {
            var time = times[i];
            var tmpArray = time.split(':');
            if(tmpArray.length == 3) {
                timeTotal += parseInt(tmpArray[0]) * 3600;
                timeTotal += parseInt(tmpArray[1]) * 60;
                timeTotal += parseInt(tmpArray[2]);
            } else {
                timeTotal += parseInt(tmpArray[0]) * 60;
                timeTotal += parseInt(tmpArray[1]);
            }
        }

        var minutes = Math.floor(timeTotal / 60);
        timeTotal = timeTotal - minutes * 60;
        var seconds = timeTotal;
        var result = {
            minutes : minutes,
            seconds : seconds
        };

        return result;


    }
}

Courses = new Meteor.Collection('courses', {
    transform: function(document) {
        return new Course(document);
    }
});



Courses.allow({
    insert: function(userId, doc) {
        if(userId) {
            return true;
        }
        return false;
    },
    update : function(userId, doc, fieldNames, modifier) {
        if(userId == doc.author) {
            return true;
        }

        return false;
    },
    remove : function(userId, doc) {
        if(userId == doc.author) {
            return true;
        }

        return false;
    }
});





Meteor.methods({
    createCourse : function(doc) {
        return Courses.insert(doc, function(err, result) {
            if(err) {
                throw new Meteor.Error(404, "插入课程数据失败！");
            } else {
                return result;
            }
        });
    }
});
