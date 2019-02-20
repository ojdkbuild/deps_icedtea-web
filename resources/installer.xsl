<?xml version="1.0" encoding="UTF-8"?>
<!--
 Copyright 2016 akashche at redhat.com

 Licensed under the Apache License, Version 2.0 (the "License");
 you may not use this file except in compliance with the License.
 You may obtain a copy of the License at

 http://www.apache.org/licenses/LICENSE-2.0

 Unless required by applicable law or agreed to in writing, software
 distributed under the License is distributed on an "AS IS" BASIS,
 WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 See the License for the specific language governing permissions and
 limitations under the License.
-->
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:w="http://schemas.microsoft.com/wix/2006/wi" exclude-result-prefixes="w">
    <xsl:template match="@*|node()">
        <xsl:copy>
            <xsl:apply-templates select="@*|node()"/>
        </xsl:copy>
    </xsl:template>
    <xsl:template match="w:Directory[@Id='INSTALLDIR']">
        <Directory Id="INSTALLDIR" xmlns="http://schemas.microsoft.com/wix/2006/wi">
            <xsl:apply-templates select="@* | *"/>
            <Directory Id="WEBSTARTDIR" Name="webstart">

                <!-- webstart -->
                <Component Id="webstart_javaws_jar" Guid="553f6ce7-1c85-49af-af34-1fbf0de7c3f8" Win64="${openjdk_INSTALLER_WIN64_WIX}">
                    <File Id="webstart_javaws_jar_file" Name="javaws.jar" KeyPath="yes" DiskId="1"
                          Source="webstart/javaws.jar"/>
                </Component>
                <Component Id="webstart_javaws_exe" Guid="8b04c2a7-4474-4c81-a8c2-6ad6e92d1269" Win64="${openjdk_INSTALLER_WIN64_WIX}">
                    <File Id="webstart_javaws_exe_file" Name="javaws.exe" KeyPath="yes" DiskId="1"
                          Source="webstart/javaws.exe"/>
                </Component>
                <Component Id="webstart_javaws_options" Guid="5dd2346f-3890-4e63-8727-170a183ac297" Win64="${openjdk_INSTALLER_WIN64_WIX}">
                    <File Id="webstart_javaws_options_file" Name="javaws_options.txt" KeyPath="yes" DiskId="1"
                          Source="webstart/javaws_options.txt"/>
                </Component>
                <Component Id="webstart_javaws_splash" Guid="f5b85994-0e3b-4689-8ac1-0e614c8b574e" Win64="${openjdk_INSTALLER_WIN64_WIX}">
                    <File Id="webstart_javaws_splash_file" Name="javaws_splash.png" KeyPath="yes" DiskId="1"
                          Source="webstart/javaws_splash.png"/>
                </Component>

            </Directory>
        </Directory>

        <!-- webstart_registry -->
        <Component Id="webstart_registry_jnlp_content_type" Guid="af7ef2b5-afd0-4b5e-bb06-031e6f70b677" Win64="${openjdk_INSTALLER_WIN64_WIX}" xmlns="http://schemas.microsoft.com/wix/2006/wi">
            <RegistryKey Id="webstart_registry_jnlp_content_type_key" ForceCreateOnInstall="yes" Key="SOFTWARE\Classes\.jnlp" Root="HKLM">
                <RegistryValue Value="JNLPFile" Type="string"/>
                <RegistryValue Name="Content Type" Value="application/x-java-jnlp-file" Type="string"/>
            </RegistryKey>
        </Component>
        <Component Id="webstart_registry_jnlp_protocol" Guid="3d684efc-e11c-4b3d-a57e-b2f592428a63" Win64="${openjdk_INSTALLER_WIN64_WIX}" xmlns="http://schemas.microsoft.com/wix/2006/wi">
            <RegistryKey Id="webstart_registry_jnlp_protocol_key" ForceCreateOnInstall="yes" Key="SOFTWARE\Classes\jnlp" Root="HKLM">
                <RegistryValue Value="URL:jnlp Protocol" Type="string"/>
                <RegistryValue Name="URL Protocol" Value="" Type="string"/>
            </RegistryKey>
        </Component>
        <Component Id="webstart_registry_jnlp_cmd" Guid="1b146849-380a-4915-b344-65dc3b6cd026" Win64="${openjdk_INSTALLER_WIN64_WIX}" xmlns="http://schemas.microsoft.com/wix/2006/wi">
            <RegistryKey Id="webstart_registry_jnlp_cmd_key" ForceCreateOnInstall="yes" Key="SOFTWARE\Classes\jnlp\Shell\Open\Command" Root="HKLM">
                <RegistryValue Value="&quot;[WEBSTARTDIR]javaws.exe&quot; &quot;%1&quot;" Type="string"/>
            </RegistryKey>
        </Component>
        <Component Id="webstart_registry_jnlps_protocol" Guid="4b286e60-f0cf-447b-8698-01d31819ab02" Win64="${openjdk_INSTALLER_WIN64_WIX}" xmlns="http://schemas.microsoft.com/wix/2006/wi">
            <RegistryKey Id="webstart_registry_jnlps_protocol_key" ForceCreateOnInstall="yes" Key="SOFTWARE\Classes\jnlps" Root="HKLM">
                <RegistryValue Value="URL:jnlps Protocol" Type="string"/>
                <RegistryValue Name="URL Protocol" Value="" Type="string"/>
            </RegistryKey>
        </Component>
        <Component Id="webstart_registry_jnlps_cmd" Guid="e743d0a1-309a-4daf-bfa7-23c660323605" Win64="${openjdk_INSTALLER_WIN64_WIX}" xmlns="http://schemas.microsoft.com/wix/2006/wi">
            <RegistryKey Id="webstart_registry_jnlps_cmd_key" ForceCreateOnInstall="yes" Key="SOFTWARE\Classes\jnlps\Shell\Open\Command" Root="HKLM">
                <RegistryValue Value="&quot;[WEBSTARTDIR]javaws.exe&quot; &quot;%1&quot;" Type="string"/>
            </RegistryKey>
        </Component>
        <Component Id="webstart_registry_jnlp_file_type" Guid="11c5c847-7be3-4fb1-b7bf-0916105b2cf9" Win64="${openjdk_INSTALLER_WIN64_WIX}" xmlns="http://schemas.microsoft.com/wix/2006/wi">
            <RegistryKey Id="webstart_registry_jnlp_file_type_key" ForceCreateOnInstall="yes" Key="SOFTWARE\Classes\JNLPFile" Root="HKLM">
                <RegistryValue Value="JNLP File" Type="string"/>
                <RegistryValue Name="EditFlags" Value="65536" Type="integer"/>
            </RegistryKey>
        </Component>
        <Component Id="webstart_registry_jnlp_menu" Guid="74e574c8-a77e-4686-b20d-f22462530e8e" Win64="${openjdk_INSTALLER_WIN64_WIX}" xmlns="http://schemas.microsoft.com/wix/2006/wi">
            <RegistryKey Id="webstart_registry_jnlp_menu_key" ForceCreateOnInstall="yes" Key="SOFTWARE\Classes\JNLPFile\Shell\Open" Root="HKLM">
                <RegistryValue Value="&amp;Launch with ${openjdk_VENDOR_SHORT} WebStart" Type="string"/>
            </RegistryKey>
        </Component>
        <Component Id="webstart_registry_jnlp_file_cmd" Guid="64c4654e-7e54-48b2-8845-4f38f8cd4095" Win64="${openjdk_INSTALLER_WIN64_WIX}" xmlns="http://schemas.microsoft.com/wix/2006/wi">
            <RegistryKey Id="webstart_registry_jnlp_file_cmd_key" ForceCreateOnInstall="yes" Key="SOFTWARE\Classes\JNLPFile\Shell\Open\Command" Root="HKLM">
                <RegistryValue Value="&quot;[WEBSTARTDIR]javaws.exe&quot; &quot;%1&quot;" Type="string"/>
            </RegistryKey>
        </Component>

        <!-- webstart_env -->
        <Component Id="webstart_env_path_comp" Guid="2747e9f5-00c6-428e-95ce-a125a16bff21" KeyPath="yes" Win64="${openjdk_INSTALLER_WIN64_WIX}" xmlns="http://schemas.microsoft.com/wix/2006/wi">
            <Environment Id="webstart_env_path_key" Name="PATH" Value="[WEBSTARTDIR]" Action="set" Part="last" System="yes"/>
        </Component>

    </xsl:template>
    <xsl:template match="w:Feature[@ConfigurableDirectory='INSTALLDIR']">
        <Feature Id="jdk" xmlns="http://schemas.microsoft.com/wix/2006/wi">
            <xsl:apply-templates select="@* | *"/>
        </Feature>
        <Feature Id="webstart" Absent="allow" AllowAdvertise="no" Level="${${PROJECT_NAME}_INSTALLER_FEATURE_LEVEL}" 
                Title="${${PROJECT_NAME}_INSTALLER_FEATURE_TITLE}"
                Description="Web Start implementation based on IcedTea-Web open-source project."
                xmlns="http://schemas.microsoft.com/wix/2006/wi">
            <ComponentRef Id="webstart_javaws_jar"/>
            <ComponentRef Id="webstart_javaws_exe"/>
            <ComponentRef Id="webstart_javaws_options"/>
            <ComponentRef Id="webstart_javaws_splash"/>

            <Feature Id="webstart_registry" Absent="allow" AllowAdvertise="no" Level="${${PROJECT_NAME}_INSTALLER_FEATURE_LEVEL}"
                     Title="JNLP Files Association"
                     Description="Allows to run JNLP files and 'jnlp://' URLs from web browsers and Windows Explorer."
                     xmlns="http://schemas.microsoft.com/wix/2006/wi">
                <ComponentRef Id="webstart_registry_jnlp_content_type"/>
                <ComponentRef Id="webstart_registry_jnlp_protocol"/>
                <ComponentRef Id="webstart_registry_jnlp_cmd"/>
                <ComponentRef Id="webstart_registry_jnlps_protocol"/>
                <ComponentRef Id="webstart_registry_jnlps_cmd"/>
                <ComponentRef Id="webstart_registry_jnlp_file_type"/>
                <ComponentRef Id="webstart_registry_jnlp_menu"/>
                <ComponentRef Id="webstart_registry_jnlp_file_cmd"/>
            </Feature>

            <Feature Id="webstart_env" Absent="allow" AllowAdvertise="no" Level="${${PROJECT_NAME}_INSTALLER_FEATURE_LEVEL}"
                     Title="PATH Variable"
                     Description="Appends '&lt;jdk&gt;/webstart' to the 'PATH' system environment variable."
                     xmlns="http://schemas.microsoft.com/wix/2006/wi">
                <ComponentRef Id="webstart_env_path_comp"/>
            </Feature>

            <Feature Id="webstart_migrate" Absent="allow" AllowAdvertise="no" Level="${${PROJECT_NAME}_INSTALLER_FEATURE_LEVEL}"
                     Title="Keep settings and cache"
                     Description="Keeps WebStart settings and cache files intact on update."
                     xmlns="http://schemas.microsoft.com/wix/2006/wi">
                <ComponentRef Id="webstart_env_path_comp"/>
            </Feature>
        </Feature>

        <!-- impersonated -->
        <CustomAction Id="itw_cleanup_impersonated_prop" Property="WixQuietExec${openjdk_INSTALLER_WIN64_EXEC_WIX}CmdLine" Value="&quot;[WEBSTARTDIR]javaws.exe&quot; -d" xmlns="http://schemas.microsoft.com/wix/2006/wi"/>
        <CustomAction Id="itw_cleanup_impersonated" BinaryKey="WixCA" DllEntry="WixQuietExec${openjdk_INSTALLER_WIN64_EXEC_WIX}" Return="ignore" xmlns="http://schemas.microsoft.com/wix/2006/wi"/>

        <!-- immediate -->
        <CustomAction Id="itw_migrate_immediate" Property="itw_migrate_deferred" Value="&quot;[WEBSTARTDIR]javaws.exe&quot; -m" xmlns="http://schemas.microsoft.com/wix/2006/wi"/>

        <!-- deferred -->
        <CustomAction Id="itw_migrate_deferred" BinaryKey="WixCA" DllEntry="WixQuietExec${openjdk_INSTALLER_WIN64_EXEC_WIX}" Return="ignore" Execute="deferred" Impersonate="no" xmlns="http://schemas.microsoft.com/wix/2006/wi"/>

        <InstallExecuteSequence xmlns="http://schemas.microsoft.com/wix/2006/wi">
            <!-- impersonated -->
            <Custom Action="itw_cleanup_impersonated_prop" Before="itw_cleanup_impersonated"><![CDATA[!webstart=3 AND REMOVE AND (NOT (!webstart_migrate=3 AND UPGRADINGPRODUCTCODE))]]></Custom>
            <Custom Action="itw_cleanup_impersonated" Before="RemoveFiles"><![CDATA[!webstart=3 AND REMOVE AND (NOT (!webstart_migrate=3 AND UPGRADINGPRODUCTCODE))]]></Custom>

            <!-- immediate -->
            <Custom Action="itw_migrate_immediate" Before="InstallInitialize"><![CDATA[&webstart_migrate=3 AND NOT !webstart_migrate=3]]></Custom>

            <!-- deferred -->
            <Custom Action="itw_migrate_deferred" Before="InstallFinalize"><![CDATA[&webstart_migrate=3 AND NOT !webstart_migrate=3]]></Custom>
        </InstallExecuteSequence>
    </xsl:template>
</xsl:stylesheet>
