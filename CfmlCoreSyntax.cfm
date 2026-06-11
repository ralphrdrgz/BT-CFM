<cfset homeBuilder = {
    name = "Sunrise Homes",
    city = "Austin",
    state = "Texas",
    beds = 4,
    price = 425000
}>

<h2>Homebuilder Properties</h2>

<cfloop item="property" collection="#homeBuilder#">
    <cfoutput><li style="list-style: none"><strong>#property#:</strong> #homeBuilder[property]#</li></cfoutput>
</cfloop>

<hr>

<cfset communities = [
    "Riverwalk Village",
    "Maple Creek",
    "Oak Ridge Estates"
]>

<h2>Community List</h2>

<ol>
<cfloop array="#communities#" index="community">
<cfoutput><li>#community#</li></cfoutput>
</cfloop>
</ol>

<hr>

<h2>Price Category</h2>

<cfif homeBuilder.price GT 300000>
    Luxury
<cfelse>
    Affordable
</cfif>
