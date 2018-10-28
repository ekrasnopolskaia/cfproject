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

  <!--- Check if user already Logged In --->
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

  <!--- If user not Logged In : go to Sign Up Form --->
  <cfelse>
    <cfoutput>
        <form name="signUp" method="post" action="/index.cfm?component=user&method=signUp">
          <p><b>Login:</b><br>
            <input name="login" type="text" size="40"
            <cfif (structKeyExists(Form, "login") )>
               value="#Form.login#">
            <cfelse>
              value="">
            </cfif>
          </p>
          <p><b>Password:</b><br>
            <input name="password" type="password" size="40"
            <cfif (structKeyExists(Form, "password") )>
              value="#Form.password#">
            <cfelse>
              value="">
            </cfif>
          </p>
          <p><b>Repeat Password:</b><br>
            <input name="repeatPassword" type="password" size="40"
            <cfif (structKeyExists(Form, "password") )>
              value="#Form.repeatPassword#">
            <cfelse>
              value="">
            </cfif>
          </p>
          <p>
            <input type="submit" value="Submit">
            <input type="reset" value="Clear">
          </p>
        </form>

        <p> Already have an account? </p>
        <a href="/index.cfm?component=user&method=signIn">
          <input type="button" value="Sign In">
        </a>
    </cfoutput>

    <!--- Make error list --->
    <cfset err = []>
    <!--- Check if Sign Up Form fullfilled --->
    <cfif (structKeyExists(Form, "login") and structKeyExists(Form, "password"))>

      <!--- Check Login Pattern --->
      <cfif not isValid("regex", Form.login, "^[a-zA-Z0-9_]+$")>
        <cfset errorMsg = "Login must contain only latin letters, digits and underscore">
        <cfset ArrayAppend(err,errorMsg)>
      </cfif>
      <cfif (Len(Form.login) lt 3 or Len(Form.login) gt 30)>
        <cfset errorMsg = "Login must contain not less than 3 and not more than 30 symbols">
        <cfset ArrayAppend(err,errorMsg)>
      </cfif>

      <!--- Check Password Pattern --->
      <cfif (Len(Form.password) lt 3 or Len(Form.password) gt 30)>
        <cfset errorMsg = "Password must contain not less than 3 and not more than 30 symbols">
        <cfset ArrayAppend(err,errorMsg)>
      </cfif>

      <cfif Form.password neq Form.repeatPassword>
        <cfset errorMsg = "Fields Password and Reapeat Password are not the same">
        <cfset ArrayAppend(err,errorMsg)>
      </cfif>

      <!--- Check if User already exists --->
      <cfquery name="userExists" datasource="authdata">
      	SELECT COUNT(user_id) exist
      	FROM users
      	WHERE user_login = <cfqueryparam value="#Form.login#" cfsqltype="cf_sql_varchar" />
      </cfquery>
      <cfloop query="userExists">
          <cfif userExists.exist gt 0>
            <cfset errorMsg = "Such user exists">
            <cfset ArrayAppend(err,errorMsg)>
          </cfif>
      </cfloop>

      <!--- If no errors exist : add new user to database --->
      <cfif ArrayLen(err) lt 1>
        <!--- Hash the password with salt to store in database --->
        <cfset passwordHash = Hash((saltHash & Trim(Form.password)), "SHA")>

        <cfquery name="insertUser" datasource="authdata">
          INSERT INTO [users]
            ([user_login],[user_password])
          VALUES
            (<cfqueryparam value="#Form.login#" cfsqltype="cf_sql_varchar" />,
            '#passwordHash#')
        </cfquery>
        <cfoutput> Registered: #Trim(Form.login)# </cfoutput>
        <cfset invoke(this, Redirect("?component=user&method=signIn"))>
      <!--- if errors occurred : show problems --->
      <cfelse>
        <div class="text-warning pt-3">
          <cfoutput>
            <p> #ArrayLen(err)# errors occured: </p>
          </cfoutput>
          <cfloop array="#err#" item="val">
            <cfoutput>
              <p> #val# </p>
            </cfoutput>
          </cfloop>
        </div>
      </cfif>

    </cfif>

  </cfif>
</div>
