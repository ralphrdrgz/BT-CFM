<cfinclude template="helper.cfm">


<cfparam name = "url.city" default = "Abilene">
<cfparam name = "url.state"  default = "TX">
<cfparam name = "url.beds"  default = "3">

<cfparam name = "url.baths"  default = "2">

<cfoutput>
    #url.city#, #url.state# - #url.beds# #formatBedBath#
</cfoutput>
