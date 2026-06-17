<cfparam name="URL.id" default="0">

<cfif URL.id GT 0>
    <cfquery name="qGetNote" datasource="crms">
        DELETE
        FROM
            notepad
        WHERE
            id = <cfqueryparam value="#URL.id#">
    </cfquery>
    <cflocation url="FormsCRUDURLRoutingBasics.cfm" addtoken="false">
</cfif>
