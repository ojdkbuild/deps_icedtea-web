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
        <Directory>
            <xsl:apply-templates select="@* | *"/>
            <Directory Id="WEBSTARTDIR" Name="webstart">
                <Component Id="_96a91f97_d5d0_405e_800c_dc118bc77bff" Guid="553f6ce7-1c85-49af-af34-1fbf0de7c3f8" Win64="yes">
                    <File Id="_6173755a_5dc5_4410_93c1_cd8baa6c22f4" Name="javaws.jar" KeyPath="yes" DiskId="1"
                            Source="${CMAKE_CURRENT_BINARY_DIR}/dist/javaws.jar"/>
                </Component>
                <Component Id="_ab22ec7d_edaf_4313_bbbc_4ff150cd9413" Guid="8b04c2a7-4474-4c81-a8c2-6ad6e92d1269" Win64="yes">
                    <File Id="_7f87a404_1d94_4388_a7da_70bb1e7d3fe8" Name="javaws.exe" KeyPath="yes" DiskId="1"
                            Source="${CMAKE_CURRENT_BINARY_DIR}/dist/javaws.exe"/>
                </Component>
                <Component Id="_3e4cc2d4_9411_494f_8ef0_1b939ff1e65b" Guid="f5b85994-0e3b-4689-8ac1-0e614c8b574e" Win64="yes">
                    <File Id="_0851625f_6163_4968_a2cd_584cd8eea721" Name="javaws_splash.png" KeyPath="yes" DiskId="1"
                            Source="${CMAKE_CURRENT_BINARY_DIR}/dist/javaws_splash.png"/>
                </Component>
            </Directory>
        </Directory>
        <Component Id="_af5fdb61_c8cc_4f63_8a3a_82d618335fdf" Guid="3d684efc-e11c-4b3d-a57e-b2f592428a63" Win64="yes">
            <RegistryKey Id="_bab7a9b9_6bd4_480b_94b4_50840b45c0a3" ForceCreateOnInstall="yes" Key="jnlp" Root="HKCR">
                <RegistryValue Value="URL:jnlp Protocol" Type="string"/>
                <RegistryValue Name="URL Protocol" Value="" Type="string"/>
            </RegistryKey>
        </Component>
        <Component Id="_45b47d8b_a4ce_478c_9106_71a7c517b552" Guid="1b146849-380a-4915-b344-65dc3b6cd026" Win64="yes">
            <RegistryKey Id="_69631399_61c6_4226_8da7_ca1348771efd" ForceCreateOnInstall="yes" Key="jnlp\Shell\Open\Command" Root="HKCR">
                <RegistryValue Value="&quot;[WEBSTARTDIR]javaws.exe&quot; &quot;%1&quot;" Type="string"/>
            </RegistryKey>
        </Component>
        <Component Id="_7480c4bd_8126_4d28_81ef_ae377acbc3fb" Guid="4b286e60-f0cf-447b-8698-01d31819ab02" Win64="yes">
            <RegistryKey Id="_96265d5c_7c8f_4922_b636_6175ca131e80" ForceCreateOnInstall="yes" Key="jnlps" Root="HKCR">
                <RegistryValue Value="URL:jnlps Protocol" Type="string"/>
                <RegistryValue Name="URL Protocol" Value="" Type="string"/>
            </RegistryKey>
        </Component>
        <Component Id="_1400b3b1_3448_4f2d_848e_8b0096f8be83" Guid="e743d0a1-309a-4daf-bfa7-23c660323605" Win64="yes">
            <RegistryKey Id="_be1d9931_44f4_4349_8753_7db725318fd5" ForceCreateOnInstall="yes" Key="jnlps\Shell\Open\Command" Root="HKCR">
                <RegistryValue Value="&quot;[WEBSTARTDIR]javaws.exe&quot; &quot;%1&quot;" Type="string"/>
            </RegistryKey>
        </Component>
        <Component Id="_48831d69_87a0_4a26_867a_73cfd5a9c167" Guid="11c5c847-7be3-4fb1-b7bf-0916105b2cf9" Win64="yes">
            <RegistryKey Id="_377be15c_0ecf_402d_b04b_0eb4d8767e1a" ForceCreateOnInstall="yes" Key="JNLPFile" Root="HKCR">
                <RegistryValue Value="JNLP File" Type="string"/>
                <RegistryValue Name="EditFlags" Value="65536" Type="integer"/>
            </RegistryKey>
        </Component>
        <Component Id="_a19d7897_1e2a_4619_bc04_a51ec8cec3c4" Guid="74e574c8-a77e-4686-b20d-f22462530e8e" Win64="yes">
            <RegistryKey Id="_f894db3a_aa13_46fc_84c6_bc476273f831" ForceCreateOnInstall="yes" Key="JNLPFile\Shell\Open" Root="HKCR">
                <RegistryValue Value="&amp;Launch" Type="string"/>
            </RegistryKey>
        </Component>
        <Component Id="_4f1b15f8_e1f9_4847_b0fe_659c42c53e8a" Guid="64c4654e-7e54-48b2-8845-4f38f8cd4095" Win64="yes">
            <RegistryKey Id="_e85b7af7_f7e1_4fbb_8a89_a921438764ba" ForceCreateOnInstall="yes" Key="JNLPFile\Shell\Open\Command" Root="HKCR">
                <RegistryValue Value="&quot;[WEBSTARTDIR]javaws.exe&quot; &quot;%1&quot;" Type="string"/>
            </RegistryKey>
        </Component>
    </xsl:template>
    <xsl:template match="w:Feature[@ConfigurableDirectory='INSTALLDIR']">
        <Feature>
            <xsl:apply-templates select="@* | *"/>
        </Feature>
        <Feature Id="webstart" Absent="allow" AllowAdvertise="no" Level="${${PROJECT_NAME}_INSTALLER_FEATURE_LEVEL}" 
                Title="${${PROJECT_NAME}_INSTALLER_FEATURE_TITLE}"
                Description="Web Start implementation based on IcedTea-Web open-source project.">
            <ComponentRef Id="_96a91f97_d5d0_405e_800c_dc118bc77bff"/>
            <ComponentRef Id="_ab22ec7d_edaf_4313_bbbc_4ff150cd9413"/>
            <ComponentRef Id="_3e4cc2d4_9411_494f_8ef0_1b939ff1e65b"/>

            <ComponentRef Id="_af5fdb61_c8cc_4f63_8a3a_82d618335fdf"/>
            <ComponentRef Id="_45b47d8b_a4ce_478c_9106_71a7c517b552"/>
            <ComponentRef Id="_7480c4bd_8126_4d28_81ef_ae377acbc3fb"/>
            <ComponentRef Id="_1400b3b1_3448_4f2d_848e_8b0096f8be83"/>
            <ComponentRef Id="_48831d69_87a0_4a26_867a_73cfd5a9c167"/>
            <ComponentRef Id="_a19d7897_1e2a_4619_bc04_a51ec8cec3c4"/>
            <ComponentRef Id="_4f1b15f8_e1f9_4847_b0fe_659c42c53e8a"/>
        </Feature>

        <!-- impersonated -->
        <!-- property already added by update_notifier -->
        <!--Property Id="WixQuietExec64CmdLine" Value=" "/-->
        <CustomAction Id="itw_cleanup_impersonated_prop" Property="WixQuietExec64CmdLine" Value="&quot;[WEBSTARTDIR]javaws.exe&quot; -d"/>
        <CustomAction Id="itw_cleanup_impersonated" BinaryKey="WixCA" DllEntry="WixQuietExec64" Return="ignore"/>

        <InstallExecuteSequence>
            <!-- impersonated -->
            <Custom Action="itw_cleanup_impersonated_prop" Before="itw_cleanup_impersonated"><![CDATA[!webstart=3 AND REMOVE]]></Custom>
            <Custom Action="itw_cleanup_impersonated" Before="RemoveFiles"><![CDATA[!webstart=3 AND REMOVE]]></Custom>
        </InstallExecuteSequence>
    </xsl:template>
</xsl:stylesheet>
