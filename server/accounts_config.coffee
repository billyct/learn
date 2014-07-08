

ServiceConfiguration.configurations.remove({
  service: "github"
});

ServiceConfiguration.configurations.insert({
  service: "github",
  clientId: "0fc2b5ae4cf8bc7bf330",
  secret: "52d062ee0335ec002c1cd9aeaf73206de46cc3da"
});

ServiceConfiguration.configurations.remove({
  service: "weibo"
});

ServiceConfiguration.configurations.insert({
  service: "weibo",
  clientId: "320306549",
  secret: "774a1b91d2571bab41f16aedbc2c0b6a"
});



profileConvert = (profile, type) ->
    if type is 'weibo'
        profileConverted = {
            name : profile.name
            avatar : profile.profile_image_url
        }
    if type is 'github'
        profileConverted = {
            name : profile.name
            avatar : profile.avatar_url
            github : true
            github_url : "http://github.com/"+profile.name
        }

    return profileConverted

Accounts.onCreateUser (options, user) ->

    if Meteor.users.find().count() is 0
        user.isAdmin = true

    if user.services.password
        profile = {
            name : user.username
            avatar : get_gravatar(user.emails[0].address)
        }

        user.profile = profile


    if user.services.github
        accessToken = user.services.github.accessToken

        result = Meteor.http.get('https://api.github.com/user',{
                        params: {access_token : accessToken },
                        headers : {"User-Agent": "Meteor/1.0"}
        })
        if result.error
            console.log result
            throw result.error

        profile = _.pick(result.data,
                'name',
                'avatar_url')

        emailsResult = Meteor.http.get('https://api.github.com/user/emails', {
                        params: {access_token : accessToken },
                        headers : {"User-Agent": "Meteor/1.0"}
        })

        if emailsResult.error
            console.log emailsResult
            throw emailsResult.error


        user.username = profile.name
        user.emails = emailsResult.data
        user.profile = profileConvert profile, 'github'

    # if user.services.weibo
    #     accessToken = user.services.weibo.accessToken
    #
    #     result = Meteor.http.get('https://api.weibo.com/2/users/show.json', {
    #                     params: { access_token : accessToken, uid : user.services.weibo.id },
    #                     headers : {"User-Agent": "Meteor/1.0"}
    #     })
    #
    #     if result.error
    #         console.log result
    #         throw result.error
    #
    #     profile = _.pick(result.data,
    #             'name',
    #             'profile_image_url',
    #             'location')
    #
    #     emailResult = Meteor.http.get("https://api.weibo.com/2/account/profile/email.json", {
    #                     params : {access_token : accessToken},
    #                     headers : {"User-Agent": "Meteor/1.0"}
    #     })
    #
    #     if emailResult.error
    #         console.log emailResult
    #         throw emailResult.error
    #
    #     profile.emails = _.pluck(emailResult.data, 'email')
    #
    #     user.profile = profileConvert profile, 'weibo'

    return user
