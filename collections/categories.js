
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
