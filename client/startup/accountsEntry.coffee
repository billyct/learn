Meteor.startup(->
  AccountsEntry.config
    logo: '/images/login_logo.png'
    homeRoute: '/'
    dashboardRoute: if Session.get('url-target')? then Session.get('url-target') else '/profile'
    showSignupCode: false
    language : AppSetting.language
    passwordSignupFields: 'USERNAME_AND_OPTIONAL_EMAIL'
    signInTemplate : 'entry_signIn'
    signUpTemplate : 'entry_signUp'
)


Accounts.ui.config({
  requestPermissions: {
    weibo: ['email'],
    github: ['user']
  }
});
