<cfset sum = 0 />

<cfloop file="2.txt" item="row">
	<cfset rowNumbers = ListToArray(row, Chr(9)) />
	<cfset sum += ArrayMax(rowNumbers) - ArrayMin(rowNumbers) />
</cfloop>

<cfoutput>#sum#</cfoutput>
