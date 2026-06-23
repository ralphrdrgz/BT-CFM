<cfquery name="getClientList" datasource="crms">
    SELECT ID, projectName, launchDate, websiteLink FROM clientList
</cfquery>

<cftry>
    <cfquery name="getNothing" datasource="crms">
        SELECT ID FROM noneExistingTable
    </cfquery>

    <cfcatch>
           <h3>Database Error Caught</h3>
           <p>Table not found</p>
       </cfcatch>
</cftry>

<cfset writeDump( var=getClientList, label="Get Client List" ) />

<h2>Client List</h2>
<table border="1">
    <tr>
        <th>ID#</th>
        <th>Project Name</th>
        <th>Launch Date</th>
        <th>Website Link</th>
    </tr>
    <cfloop query="getClientList">
        <cfoutput>
            <tr>
                <td>#getClientList.ID#</td>
                <td>#getClientList.projectName#</td>
                <td>#dateFormat( getClientList.launchDate, "mmmm dd, yyyy" )#</td>
                <td>#decodeForHTML(getClientList.websiteLink)#</td>

            </tr>
        </cfoutput>
    </cfloop>
</table>
