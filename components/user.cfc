<cfcomponent name="User" extends="Base" accessors="true">

  <cfset saltHash = "mySalt">
  <cfset projectDebug = true>

  <cffunction name="signIn">
    <cfset helloText = "Login Page">
    <cfset pageTitle = "Login Page">
    <cfset this.Content("SignInPage.cfm")>
  </cffunction>

  <cffunction name="signOut">
    <cfset structClear(session)>
    <cfset signIn()>
  </cffunction>

  <cffunction name="signUp">
    <cfset helloText = "Register Page">
    <cfset pageTitle = "Register Page">
    <cfset this.Content("SignUpPage.cfm")>
  </cffunction>

  <cffunction name="isPublic">
    <cfargument name="method" type="string" required="true">
    <cfreturn method eq "signIn" or method eq "signUp">
  </cffunction>

</cfcomponent>
