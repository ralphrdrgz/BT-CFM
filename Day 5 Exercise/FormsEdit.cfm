<cfparam name="URL.id" default="0">

<cfif structKeyExists(FORM, "submit")>
    <cfquery datasource="crms">
        UPDATE notepad
        SET
            title = <cfqueryparam value="#FORM.title#">,
            body  = <cfqueryparam value="#FORM.body#">
        WHERE
            id = <cfqueryparam value="#URL.id#">
    </cfquery>
    <cflocation url="FormsCRUDURLRoutingBasics.cfm" addtoken="false">
</cfif>

<cfif URL.id GT 0>
    <cfquery name="qGetNote" datasource="crms">
        SELECT
            title,
            body
        FROM
            notepad
        WHERE
            id = <cfqueryparam value="#URL.id#">
    </cfquery>
</cfif>



<cfoutput>
<form method="post">
       <label for="title">Title</label><br />
       <input
           type="text"
           id="title"
           name="title"
           required
           value="#htmlEditFormat(qGetNote.title)#"
       >
       <br /><br />
       <label for="body">Body</label><br />
       <textarea
           id="body"
           name="body"
           required
       >#htmlEditFormat(qGetNote.body)#</textarea>
       <br /><br />
       <button type="submit" name="submit">
           Save Note Changes
       </button>
   </form>
</cfoutput>
