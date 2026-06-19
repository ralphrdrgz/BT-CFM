<cfparam name="activeFilter" type="integer" default="1" />

<cfset helper = new Day6Helper() />
<cfset myUtil = new Day6myUtil() />

<cfquery name="getCommunities" datasource="crms">
    SELECT
        ID
        , Name
        , City
        , State
    FROM
        communities
    WHERE
        Active = <cfqueryparam value="#activeFilter#" cfsqltype="cf_sql_integer" />
</cfquery>

<cfset myArray = helper.queryToArray( getCommunities ) />

<table border="1">
    <tr>
        <th>Community Name</th>
        <th>City</th>
        <th>State</th>
        <th>ID#</th>
    </tr>

    <cfloop array="#myArray#" index="community">

    <cfset community.Name = myUtil.titleCase( community.Name ) />
    <cfset community.City = myUtil.titleCase( community.City ) />
    <cfset community.State = myUtil.titleCase( community.State ) />
        <cfoutput>
            <tr>
                <td>#community.Name#</td>
                <td>#community.City#</td>
                <td>#community.State#</td>
                <td>#community.ID#</td>
            </tr>
        </cfoutput>
    </cfloop>
</table>
