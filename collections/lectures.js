
Lecture = function(document) {
    _.extend(this, document)
};

Lecture.prototype = {
    constructor: Lecture,

    study_progress : function() {
        var self = this;

        if(!Meteor.user()) {
            return "start"
        }

        var study = Studies.findOne({course:self.course, user:Meteor.userId()});

        var lecture = _.find(study.lectures, function(lecture) { return lecture.lecture === self._id});

        if(!lecture) {
            return "start"
        }

        if(lecture.complete) {
            return "completed";
        }

        return "inprogress"
    },

    is_completed : function() {
        var self = this;
        var study = Studies.findOne({course:self.course, user:Meteor.userId()});
        var lecture;
        if(study) {
            lecture = _.find(study.lectures, function(l) { return l.lecture === self._id});
            return lecture.complete;
        }
        return false;

    },

    pre_lecture : function() {
        return Lectures.findOne({order: {$lte:this.order}, _id: {$ne: this._id}}, {sort:{order:-1}, transform:null})
    },

    next_lecture : function() {
        return Lectures.findOne({order: {$gte:this.order}, _id: {$ne: this._id}}, {sort:{order:1}, transform:null})
    }
}


Lectures = new Meteor.Collection('lectures', {
    transform : function(document) {
        return new Lecture(document);
    }
});


Lectures.allow({
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


if (Meteor.isServer) {


    Meteor.methods({
        updateLecture: function(doc, modifier, id) {


            Lectures.update({_id: id}, modifier, function(err, result) {
                if (err) {
                    throw new Meteor.Error(404, t9n('err.editLecture'));
                }
            });

            return id;
        },
        createLecture: function(doc) {

            return Lectures.insert(doc, function(err, result) {
                if (err) {
                    throw new Meteor.Error(404, t9n('createLecture'));
                }
                return result;
            })
        },
        sortLecturesOnUpdate : function(section) {

            count = Lectures.findOne({section: section._id}, {sort:{order: 1}}).order;
            _.each(section.lectures, function(lecture, key) {

                Lectures.update({_id : lecture._id}, {$set : {order: count, section: section._id}}, function(err, result){
                    if (err) {
                        throw new Meteor.Error(404, t9n('sortLecture'));
                    }
                });
                count++;

            });


        },
        sortLecturesOnAdd : function(list) {
            count = 1;
            _.each(list, function(section) {
                _.each(section.lectures, function(lecture) {
                    Lectures.update({_id : lecture._id}, {$set : {order: count, section: section._id}}, function(err, result) {
                        if (err) {
                            throw new Meteor.Error(404, t9n('sortLecture'));
                        }
                        count++;
                    });

                });
            })
        }
    })
}
