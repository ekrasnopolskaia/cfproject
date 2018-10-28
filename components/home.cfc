<cfcomponent name="Home" extends="Base" accessors="true"> 
	<cffunction name="index"> 
		<cfset helloText = "Hello world!">
		<cfset this.Content("test1.cfm")> 
	</cffunction>
	
	<cffunction name="test1"> 
		<cfset helloText = "Hello world!"> 
		<cfset this.Json("test1.cfm")> 
	</cffunction> 
</cfcomponent>