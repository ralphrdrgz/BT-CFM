<cfquery name="getCommunities" datasource="crms">
    SELECT ID, Name, City, State FROM communities WHERE Active = 1
</cfquery>
<!--- Can change from active 1 to active 0 to get inactive communities--->


<table border="1">
    <tr>
        <th>Community Name</th>
        <th>City</th>
        <th>State</th>
        <th>ID#</th>
    </tr>
    <cfloop query="getCommunities">
        <cfoutput>
            <tr>
                <td>#getCommunities.Name#</td>
                <td>#getCommunities.City#</td>
                <td>#getCommunities.State#</td>
                <td>#getCommunities.ID#</td>
            </tr>
        </cfoutput>
    </cfloop>
</table>
