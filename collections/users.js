Meteor.users.allow({
    insert: function(userId, doc) {
        return false;
    },
    update : function(userId, doc, fieldNames, modifier) {
        if(userId == doc._id) {
            return true;
        }
        return false;
    },
    remove : function(userId, doc) {
        return false;
    }
});

Meteor.users.deny({
    fetch: ['services']
});


Meteor.methods({
    updateProfile : function(doc) {
        var set = {
            "profile.name" : doc.profile.name,
            "profile.introduce" : doc.profile.introduce
        };

        Meteor.users.update({_id: Meteor.userId()}, {$set:set}, function(err, result) {
            if(err) {
                throw new Meteor.Error(404, t9n('err.editUser'));
            }
            return result;
        });

    }
})
