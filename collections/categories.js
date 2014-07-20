
Category = function(document) {
    return _.extend(this, document);
}

Category.prototype = {
    constructor : Category,
    course_count : function() {
        var c = Counts.findOne(this._id);
        if(!_.isUndefined(c))
            return c.count;
        return 0;
    }
}

Categories = new Meteor.Collection('categories', {
    transform: function(document) {
        return new Category(document);
    }
});

Categories.allow({
    insert: function(userId, doc) {

        if(isAdminById(userId)) {
            return true;
        }
        return false;
    },
    update : function(userId, doc, fieldNames, modifier) {
        if(isAdminById(userId)) {
            return true;
        }
        return false;
    },
    remove : function(userId, doc) {
        if(isAdminById(userId)) {
            var c = Counts.findOne(doc._id);
            if(!_.isUndefined(c) && c.count > 0)
                return true;
        }
        return false;
    }
});


Meteor.methods({
    removeCategory : function(id) {
        Categories.remove({_id : id}, function(err, result) {
            if (err) {
                throw new Meteor.Error(404, t9n('err.deleteCategory'));
            }
        });
        return id;
    },

    createCategory : function(doc) {

        return Categories.insert(doc, function(err, result){
            if (err) {
                throw new Meteor.Error(404, t9n('err.createCategory'));
            }
            return result;
        })
    }
});
