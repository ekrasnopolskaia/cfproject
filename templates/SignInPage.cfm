<div class="container bg-dark text-white p-5">

  <div class="row">
    <div class="col">
      <h1 class="h1 text-center pb-3">
        <cfoutput>
          #helloText#
        </cfoutput>
      </h1>
    </div>
  </div>

    <cfif structKeyExists(Session, "user")>

      <div class="row">
        <p>
          <cfoutput>
            Hello, #Session.user#!
          </cfoutput>
        </p>
      </div>
      <div class="row">
        <p> You are already registered </p>
      </div>
      <div class="row">
        <p> Wish to log out? </p>
      </div>
      <div class="row">
        <form name="LogOut" method="post" action="/index.cfm?component=user&method=signOut">
          <p>
            <input type="submit" value="Log Out">
          </p>
        </form
      </div>

    <cfelse>

      <cfset err = []>
      <cfif (structKeyExists(Form, "login") and structKeyExists(Form, "password"))>

        <cfquery name="findUser" datasource="authdata" result="findUserRes">
          SELECT user_password
          FROM users
          WHERE user_login = <cfqueryparam value="#Form.login#" cfsqltype="cf_sql_varchar" />
        </cfquery>

        <cfif findUserRes.recordCount gt 0>
          <cfloop query="findUser" >
          <cfset passwordHash = Hash((saltHash & Trim(Form.password)), "SHA")>
            <cfif Form.password eq findUser.user_password>
              <cfoutput> <p> Hello, #Form.login# !<br></cfoutput>
              <cfset Session.user = Form.login>
              <cfset invoke(this, Redirect(""))>
            <cfelse>
              <cfset errorMsg = "Password is not correct">
              <cfset ArrayAppend(err,errorMsg)>
            </cfif>
          </cfloop>
        <cfelse>
            <cfset errorMsg = "No such user exists">
            <cfset ArrayAppend(err,errorMsg)>
        </cfif>

      </cfif>

      <div class="row">

        <div class="offset-xs-1 col-xs-10 offset-sm-2 col-sm-8 offset-md-3 col-md-6 offset-lg-4 col-lg-4">
          <cfoutput>
            <form name="signIn" method="post" action="/index.cfm?component=user&method=signIn">
              <p><b>Login:</b><br>
                <input name="login" type="text" size="30"
                <cfif (structKeyExists(Form, "login") )>
                  value="#Form.login#">
                <cfelse>
                  value="">
                </cfif>
              </p>
              <p><b>Password:</b><br>
                <input name="password" type="password" size="30"
                <cfif (structKeyExists(Form, "password") )>
                  value="#Form.password#">
                <cfelse>
                  value="">
                </cfif>
              </p>
              <p>
                <input type="submit" value="Submit">
                <input type="reset" value="Clear">
              </p>
            </form>
          </cfoutput>
        </div>

      </div>

      <div class="row">
        <div class="offset-xs-1 col-xs-10 offset-sm-2 col-sm-8 offset-md-3 col-md-6 offset-lg-4 col-lg-4 ">
          <p> No account yet? </p>
        </div>
      </div>

      <div class="row pb-3">
        <div class="offset-xs-1 col-xs-10 offset-sm-2 col-sm-8 offset-md-3 col-md-6 offset-lg-4 col-lg-4 ">
          <a href="/index.cfm?component=user&method=signUp">
            <input type="button" value="Sign Up">
          </a>
        </div>
      </div>

      <div class="row text-warning">
        <cfif ArrayLen(err) gt 0>
          <cfoutput>
            <div class="offset-xs-1 col-xs-10 offset-sm-2 col-sm-8 offset-md-3 col-md-6 offset-lg-4 col-lg-4">
              <p> #ArrayLen(err)# errors occured: </p>
              <cfloop array="#err#" item="val">
                <p> #val# </p>
              </cfloop>
            </div>
          </cfoutput>
        </cfif>
      </div>

    </cfif>

</div>
