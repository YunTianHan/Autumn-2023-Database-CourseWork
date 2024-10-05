<!-- 4_Transformation_to_XML.xsl -->
<!-- Explanation: This is the filename or identifier of this stylesheet. -->

<!-- XSLT v1.0 Transformation -->
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <!-- Output directives: the resultant XML will be pretty-printed (indented), with UTF-8 encoding -->
    <!-- Specify that the output XML should contain a reference to the associated external DTD defined in '6_Structure.dtd' -->
    <xsl:output method="xml" indent="yes" encoding="UTF-8" standalone="no" doctype-system="6_Structure.dtd"/>

    <!-- Creating keys to uniquely identify elements -->
    <!-- 'CountryKey' is for identifying distinct Country elements by their text -->
    <!-- 'OrganizationKey' is for identifying distinct Organization elements by their 'OrganizationID' attribute -->
    <!-- 'EmployeeKey' is for identifying distinct Employee elements by their 'UserID' attribute -->
    <!-- These keys improve efficiency when locating nodes within the XSLT -->
    <xsl:key name="CountryKey" match="Country" use="."/>
    <xsl:key name="OrganizationKey" match="Organization" use="OrganizationID"/>
    <xsl:key name="EmployeeKey" match="Employee" use="UserID"/>

    <!-- The entry point template for processing the source XML -->
    <!-- This template matches the root node and processes the whole XML document -->
    <xsl:template match="/">
        <!-- Define the root element 'eCorporation' for the output XML document -->
        <eCorporation>
            <!-- Apply templates to Country elements that are unique -->
            <!-- Uses Muenchian Method for grouping distinct Country names -->
            <!-- Sorts the Country elements alphabetically by their text content before applying templates -->
            <xsl:apply-templates select="//Country[generate-id()=generate-id(key('CountryKey', .)[1])]">
                <xsl:sort select="."/>
            </xsl:apply-templates>
        </eCorporation>
    </xsl:template>

    <!-- Template for processing each unique Country element -->
    <!-- This template is used to create nested 'Country' elements in the output XML with 'name' attributes set to the respective country names -->
    <xsl:template match="Country">
        <Country name="{.}">
            <!-- Apply templates to Organization elements belonging to the current Country context -->
            <!-- Ensures that each Organization is only processed once using the unique 'OrganizationKey' -->
            <!-- Sorts the Organization elements alphabetically by their 'Name' element before applying templates -->
            <xsl:apply-templates select="//Organization[Country=current()][generate-id()=generate-id(key('OrganizationKey', OrganizationID)[1])]">
                <xsl:sort select="Name"/>
            </xsl:apply-templates>
        </Country>
    </xsl:template>

    <!-- Template for processing each unique Organization element within a Country context -->
    <!-- Creates 'Organization' elements and sets their 'OrganizationID' attribute -->
    <!-- Copies various child elements (like 'Name', 'Website', etc.) of the Organization element from the source XML -->
    <xsl:template match="Organization">
        <Organization OrganizationID="{OrganizationID}">
            <!-- Copy specific child elements ('Name', 'Website', 'Description', etc.) from the source to the output document -->
            <xsl:copy-of select="Name | Website | Description | Founded | Industry | NumberEmployees"/>
            <!-- Define a variable 'employeeInfo' to hold the content of an external XML document 'Employees.xml' -->
            <xsl:variable name="employeeInfo" select="document('Employees.xml')"/>
            <!-- Apply templates to Employee elements associated with the current Organization based on 'OrganizationID' -->
            <!-- Ensures distinct processing of Employees using the 'EmployeeKey' to select unique 'UserID' entries -->
            <xsl:apply-templates select="$employeeInfo/Employees/Employee[OrganizationID=current()/OrganizationID][generate-id()=generate-id(key('EmployeeKey', UserID)[1])]"/>
        </Organization>
    </xsl:template>

    <!-- Template for processing Employee elements -->
    <!-- Groups Employee elements under 'Employees' parent elements -->
    <!-- Sets their 'UserID' attribute and copies relevant child elements -->
    <xsl:template match="Employee">
        <Employees UserID="{UserID}">
            <!-- Copy specific child elements ('FirstName', 'LastName', 'Sex', etc.) from the source Employee elements to the output document -->
            <xsl:copy-of select="FirstName | LastName | Sex | Email | Phone | BirthDate | JobTitle"/>
        </Employees>
    </xsl:template>
</xsl:stylesheet>