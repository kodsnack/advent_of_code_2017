<cfset input = FileRead('1.txt') />
<cfset inputLength = Len(input) />
<cfset offset = 1 />
<cfset sum = 0 />

<cfloop from="1" to="#inputLength#" item="pos">
	<cfset currentDigit = Mid(input, pos, 1) />
	<cfset otherDigit = Mid(input, (pos + offset - 1) mod inputLength + 1, 1) />
	<cfif currentDigit eq otherDigit>
		<cfset sum += currentDigit />
	</cfif>
</cfloop>

<cfoutput>#sum#</cfoutput>
