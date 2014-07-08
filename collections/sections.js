Section = function(document) {
    _.extend(this, document);
}


Section.prototype = {
    constructor : Section,
    lectures : function () {
        return Lectures.find({section: this._id}, {sort:{order: 1}}).fetch();
    }
}

Sections = new Meteor.Collection('sections', {
    transform : function(document) {
        return new Section(document);
    }
});



Sections.allow({
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
    createSection : function(doc) {
        return Sections.insert(doc, function(err, result) {
            if(err) {
                throw new Meteor.Error(404, "插入章节失败！");
            }
            return result;
        });
    }
})
