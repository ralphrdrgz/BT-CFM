<cfquery name="getNotepad" datasource="crms">
    SELECT
        id,
        title,
        body
    FROM
        notepad
</cfquery>
<!--- Can change from active 1 to active 0 to get inactive communities--->


<table border="1">
    <tr>
        <th>ID</th>
        <th>Title</th>
        <th colspan="3">Body</th>

    </tr>
    <cfoutput query="getNotepad">
        <tr>
            <td>#getNotepad.id#</td>
            <td>#getNotepad.title#</td>
            <td>#getNotepad.body#</td>
            <td><a href="FormsEdit.cfm?id=#getNotepad.id#">Edit</a></td>
            <td><a href="FormsDelete.cfm?id=#getNotepad.id#">Delete</a></td>
        </tr>
    </cfoutput>
</table>

<br />
<form action="FormsAdd.cfm" method="get">
    <button type="submit" class="btn">Add New Note</button>
</form>
