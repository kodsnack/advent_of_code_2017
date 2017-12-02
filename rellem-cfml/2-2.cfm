<cfset sum = 0 />

<cfloop file="2.txt" item="row">
	<cfset rowNumbers = ListToArray(row, Chr(9)) />
	<cfloop from="1" to="#ArrayLen(rowNumbers)#" index="index1">
		<cfset number1 = rowNumbers[index1] />
		<cfloop from="#index1 + 1#" to="#ArrayLen(rowNumbers)#" index="index2">
			<cfset number2 = rowNumbers[index2] />

			<cfif number1 mod number2 eq 0>
				<cfset sum += number1 / number2 />
			<cfelseif number2 mod number1 eq 0>
				<cfset sum += number2 / number1 />
			</cfif>
		</cfloop>
	</cfloop>
</cfloop>

<cfoutput>#sum#</cfoutput>
