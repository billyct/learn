Meteor.startup(->
  AccountsEntry.config
    logo: '/images/login_logo.png'
    homeRoute: '/'
    dashboardRoute: Session.get('url-target')
    showSignupCode: false
    language : 'zh-cn'
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
