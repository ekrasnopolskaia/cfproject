<cfcomponent output="true"> 
	<cfset this.name = "testApplication"> 
	<cfset this.sessionmanagement = "Yes">
	<cfset this.sessiontimeout = CreateTimespan(0,0,45,0)>
	<cffunction name="onRequest" returnType="void"> 
		<cfargument name="targetPage" type="String" required="true" /> 
		<cfdump var="#Session#">
		<cfdump var="#form#">
		<cfset componentName = "home"> <cfset componentMethod = "index"> 
		<cfif structKeyExists(URL, "component") and URL["component"] neq ""> 
			<cfset componentName = URL["component"]> 
		</cfif> 
		<cfif structKeyExists(URL, "method") and URL["method"] neq ""> 
			<cfset componentMethod = URL["method"]> 
		</cfif> 
	
		<cfset componentObject =
			createobject("component", "getonboard.components.#componentName#")>
		<cfif not structKeyExists(session,"user")or session.user lt 0>
			<cfif not componentObject.isPublic(componentMethod)>
				<cfset componentName = "user">
				<cfset componentObject = createobject("component", "getonboard.components.#componentName#")>
				<cfset componentMethod = "signin">
			</cfif>
		</cfif>
		<cfset invoke(componentObject, componentMethod)> 
		<cfreturn> 
</cffunction> 
</cfcomponent>