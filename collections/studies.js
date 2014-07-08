Studies = new Meteor.Collection('studies');



Meteor.methods({
    studyCreate : function(courseId) {
        var doc = {
            course : courseId,
            user : Meteor.userId()
        };


        var study = Studies.findOne(doc);

        if(!study) {
            Studies.insert(doc, function(err, result) {
                if(err) {
                    throw new Meteor.Error(404, "创建学习进度失败！");
                }
            });
        }
    },
    studyLectureCreate : function(lecture) {
        var doc = {
            course : lecture.course,
            user : Meteor.userId()
        };

        var study = Studies.findOne(doc);

        if(study) {
            var l = _.find(study.lectures, function(l){return l.lecture === lecture._id});
            if (!l) {
                Studies.update({_id: study._id}, {$push:{lectures: {lecture: lecture._id, complete: false}}}, function(err, result) {
                    if(err) {
                        throw new Meteor.Error(404, "更新课时学习进度失败！");
                    }
                })
            }
        }
    },
    studyLectureComplete : function(lecture) {
        var doc = {
            course : lecture.course,
            user : Meteor.userId(),
            lectures : {$elemMatch : {lecture: lecture._id}}
        };

        // console.log(doc);

        var study = Studies.findOne(doc);

        // console.log(study);


        if(study) {

            Studies.update({_id: study._id}, {$pull:{lectures :{lecture: lecture._id, complete: false}}}, function(err, result) {
                if(err) {
                    throw new Meteor.Error(404, "更新课时学习进度失败！");
                }
            })

            Studies.update({_id: study._id}, {$addToSet:{lectures :{lecture: lecture._id, complete: true}}}, function(err, result) {
                if(err) {
                    throw new Meteor.Error(404, "更新课时学习进度失败！");
                }
            })
        }
    }
})
