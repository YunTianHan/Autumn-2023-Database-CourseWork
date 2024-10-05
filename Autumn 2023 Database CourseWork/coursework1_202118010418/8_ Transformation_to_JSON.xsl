<?xml version="1.0" encoding="UTF-8"?>
<!-- XML document declaration and XSLT stylesheet namespace -->
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <!-- To convert to a json file, set the output to text -->
	<xsl:output method="text" indent="yes" encoding="UTF-8"/>
	<!-- Root template match, it matches the whole document node and starts processing -->
	<xsl:template match="/">
	    <!-- Root template match, it matches the whole document node and starts processing -->
		<xsl:text>{&#xA;"eCorporation": [</xsl:text>
		<!-- Apply templates for each Country element with sorting feature -->
		<xsl:apply-templates select="//Country">
			<xsl:sort select="."/>
		</xsl:apply-templates>
		<xsl:text>&#xA;]}</xsl:text>
	</xsl:template>
	<!-- Template for Country element to handle each Country -->
	<xsl:template match="Country">
	    <!-- Making JSON formatted with indentation and key for Country -->
		<xsl:text>&#xA;&#x9;</xsl:text>
		<xsl:text>{&#xA;&#x9;"Country": [</xsl:text>
		<!-- Apply templates for each Organization element with the current country as context and sorting feature -->
		<xsl:apply-templates select="//Organization[Country=current()]">
			<xsl:sort select="Name"/>
		</xsl:apply-templates>
		<xsl:text>&#xA;&#x9;]}</xsl:text>
		<!-- Apply templates for each Organization element with the current country as context and sorting feature -->
		<xsl:if test="position()!=last()">
			<xsl:text>,</xsl:text>
		</xsl:if>
	</xsl:template>
	<!-- Apply templates for each Organization element with the current country as context and sorting feature -->
	<xsl:template match="Organization">
	    <!-- Outputting the formatted JSON for Organization object with indentation and key-value pairs -->
		<xsl:text>&#xA;&#x9;&#x9;&#x9;</xsl:text>
		<xsl:text>{&#xA;&#x9;&#x9;&#x9;"Organization": {</xsl:text>
		<xsl:text>&#xA;&#x9;&#x9;&#x9;&#x9;"OrganizationID": "</xsl:text>
		<xsl:value-of select="OrganizationID"/>
		<xsl:text>",</xsl:text>
		<xsl:text>&#xA;&#x9;&#x9;&#x9;&#x9;"Name": "</xsl:text>
		<xsl:value-of select="Name"/>
		<xsl:text>",</xsl:text>
		<xsl:text>&#xA;&#x9;&#x9;&#x9;&#x9;"Website": "</xsl:text>
		<xsl:value-of select="Website"/>
		<xsl:text>",</xsl:text>
		<xsl:text>&#xA;&#x9;&#x9;&#x9;&#x9;"Country": "</xsl:text>
		<xsl:value-of select="Country"/>
		<xsl:text>",</xsl:text>
		<xsl:text>&#xA;&#x9;&#x9;&#x9;&#x9;"Description": "</xsl:text>
		<xsl:value-of select="Description"/>
		<xsl:text>",</xsl:text>
		<xsl:text>&#xA;&#x9;&#x9;&#x9;&#x9;"Founded": "</xsl:text>
		<xsl:value-of select="Founded"/>
		<xsl:text>",</xsl:text>
		<xsl:text>&#xA;&#x9;&#x9;&#x9;&#x9;"Industry": "</xsl:text>
		<xsl:value-of select="Industry"/>
		<xsl:text>",</xsl:text>
		<xsl:text>&#xA;&#x9;&#x9;&#x9;&#x9;"NumberEmployees": "</xsl:text>
		<xsl:value-of select="NumberEmployees"/>
		<xsl:text>",</xsl:text>
		<xsl:text>&#xA;&#x9;&#x9;&#x9;&#x9;"Employees": [</xsl:text>
		<!-- Outputting the formatted JSON for Organization object with indentation and key-value pairs -->
		<xsl:variable name="employeeInfo" select="document('Employees.xml')"/>
		<xsl:apply-templates select="$employeeInfo/Employees/Employee[OrganizationID=current()/OrganizationID]"/>
		<xsl:text>&#xA;&#x9;&#x9;&#x9;&#x9;]</xsl:text>
		<xsl:text>&#xA;&#x9;&#x9;&#x9;}}</xsl:text>
		<!-- Outputting the formatted JSON for Organization object with indentation and key-value pairs -->
		<xsl:if test="position()!=last()">
			<xsl:text>,</xsl:text>
		</xsl:if>
	</xsl:template>
	<!-- Template for the Employee element to handle each Employee -->
	<xsl:template match="Employee">
		<xsl:text>&#xA;&#x9;&#x9;&#x9;&#x9;&#x9;</xsl:text>
		<xsl:text>{&#xA;&#x9;&#x9;&#x9;&#x9;&#x9;"Employee": {</xsl:text>
		<!-- Template for the Employee element to handle each Employee -->
		<xsl:text>&#xA;&#x9;&#x9;&#x9;&#x9;&#x9;&#x9;"UserID": "</xsl:text>
		<xsl:value-of select="UserID"/>
		<xsl:text>",</xsl:text>
		<xsl:text>&#xA;&#x9;&#x9;&#x9;&#x9;&#x9;&#x9;"FirstName": "</xsl:text>
		<xsl:value-of select="FirstName"/>
		<xsl:text>",</xsl:text>
		<xsl:text>&#xA;&#x9;&#x9;&#x9;&#x9;&#x9;&#x9;"LastName": "</xsl:text>
		<xsl:value-of select="LastName"/>
		<xsl:text>",</xsl:text>
		<xsl:text>&#xA;&#x9;&#x9;&#x9;&#x9;&#x9;&#x9;"Sex": "</xsl:text>
		<xsl:value-of select="Sex"/>
		<xsl:text>",</xsl:text>
		<xsl:text>&#xA;&#x9;&#x9;&#x9;&#x9;&#x9;&#x9;"Email": "</xsl:text>
		<xsl:value-of select="Email"/>
		<xsl:text>",</xsl:text>
		<xsl:text>&#xA;&#x9;&#x9;&#x9;&#x9;&#x9;&#x9;"Phone": "</xsl:text>
		<xsl:value-of select="Phone"/>
		<xsl:text>",</xsl:text>
		<xsl:text>&#xA;&#x9;&#x9;&#x9;&#x9;&#x9;&#x9;"BirthDate": "</xsl:text>
		<xsl:value-of select="BirthDate"/>
		<xsl:text>",</xsl:text>
		<xsl:text>&#xA;&#x9;&#x9;&#x9;&#x9;&#x9;&#x9;"JobTitle": "</xsl:text>
		<xsl:value-of select="JobTitle"/>
		<xsl:text>",</xsl:text>
		<xsl:text>&#xA;&#x9;&#x9;&#x9;&#x9;&#x9;&#x9;"OrganizationID": "</xsl:text>
		<xsl:value-of select="OrganizationID"/>
		<xsl:text>"</xsl:text>
		<xsl:text>&#xA;&#x9;&#x9;&#x9;&#x9;&#x9;}}</xsl:text>
		<!-- If the current Employee is not the last, a comma is added after it for separation in JSON -->
		<xsl:if test="position()!=last()">
			<xsl:text>,</xsl:text>
		</xsl:if>
	</xsl:template>
</xsl:stylesheet>