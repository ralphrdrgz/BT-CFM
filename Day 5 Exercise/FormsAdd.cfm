<cfif structKeyExists(form, "submit")>

    <cfquery datasource="crms">
        INSERT INTO notepad (
            title,
            body
        )
        VALUES (
            <cfqueryparam value="#form.title#">,
            <cfqueryparam value="#form.body#">
        )
    </cfquery>

    <cflocation url="FormsCRUDURLRoutingBasics.cfm"></cflocation>
</cfif>

<form method="post">

    <label for="title">Title</label><br />
    <input
        type="text"
        id="title"
        name="title"
        required
    >

<br /><br />
    <label for="body">Body</label><br />
    <textarea
        id="body"
        name="body"
        required
    ></textarea>
<br /><br />
    <button type="submit" name="submit">
        Add Note
    </button>

</form>
