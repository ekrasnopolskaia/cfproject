<cfcomponent output="false"> 
	<cffunction name="Content"> 
		<cfargument name="template" type="string" required="true"> 
		<cfsavecontent variable="content"> 
			<cfinclude template="../templates/#template#"> 
		</cfsavecontent> 
		<cfinclude template="../templates/_layout.cfm"> 
	</cffunction>
	
	<cffunction name="isPublic"> 
		<cfargument name="method" type="string" required="true"> 
		<cfreturn false> 
	</cffunction>
	
	<cffunction name="Json"> 
		<cfargument name="object" required="true"> 
		<cfoutput>#serializeJSON(object)#</cfoutput> 
	</cffunction>
	
	<cffunction name="Redirect">
		<cfargument name="url" type="string" required="true"> 
		<cflocation url="#url#"> 
	</cffunction>
	
	<cffunction name="RedirectToMethod">
		<cfargument name="component" type="string" required="true"> 
		<cfargument name="method" type="string" required="true"> 
		<cflocation url="/?component=#component#&method=#method#"> 
	</cffunction>
 </cfcomponent>