<?xml version='1.0' encoding='UTF-8'?>
<xsl:stylesheet xmlns:xsl='http://www.w3.org/1999/XSL/Transform' version='2.0'>
  <xsl:output method="xml" indent="yes" />
  <xsl:template match='/'>
    <ServerPack version="3.4" xmlns="http://www.mcupdater.com" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:schemaLocation="http://www.mcupdater.com http://files.mcupdater.com/ServerPackv2.xsd">
      <xsl:for-each select='/expr/attrs/attr/attrs'>
        <xsl:choose>
          <xsl:when test = "compare(attr[@name='minecraftVersion']/string/@value, '1.16.5') = -1">
            <Server autoConnect="false" mainClass='net.minecraft.launchwrapper.Launch' newsUrl='https://madoka.brage.info/'>
              <xsl:attribute name='version'>
                <xsl:value-of select="attr[@name='minecraftVersion']/string/@value" />
              </xsl:attribute>
              <xsl:attribute name='serverAddress'>
                <xsl:value-of select="attr[@name='serverAddress']/string/@value" />
              </xsl:attribute>
              <xsl:attribute name='id'>
                <xsl:value-of select="attr[@name='serverId']/string/@value" />
              </xsl:attribute>
              <xsl:attribute name='name'>
                <xsl:value-of select="attr[@name='serverDesc']/string/@value" />
              </xsl:attribute>
              <xsl:attribute name='revision'>
                <xsl:value-of select="attr[@name='revision']/string/@value" />
              </xsl:attribute>
              <Loader type='Forge' loadOrder='0'>
                <xsl:attribute name='version'>
                  <xsl:value-of select="attr[@name='forgeVersion']/string/@value" />
                </xsl:attribute>
              </Loader>
              <xsl:for-each select="attr[@name='mods']/attrs/attr">
                <Module>
                  <xsl:attribute name='id'>
                    <xsl:value-of select="attrs/attr[@name='modId']/string/@value" />
                  </xsl:attribute>
                  <xsl:attribute name='name'>
                    <xsl:value-of select="attrs/attr[@name='name']/string/@value" />
                  </xsl:attribute>
                  <xsl:attribute name='side'>
                    <xsl:value-of select="attrs/attr[@name='side']/string/@value" />
                  </xsl:attribute>
                  <URL><xsl:value-of select="attrs/attr[@name='url']/string/@value" /></URL>
                  <Required>
                    <xsl:attribute name='isDefault'>
                      <xsl:value-of select="attrs/attr[@name='isDefault']/bool/@value" />
                    </xsl:attribute>
                    <xsl:value-of select="attrs/attr[@name='required']/bool/@value" />
                  </Required>
                  <MD5><xsl:value-of select="attrs/attr[@name='md5']/string/@value" /></MD5>
                  <ModType><xsl:value-of select="attrs/attr[@name='modtype']/string/@value" /></ModType>
                  <ModPath><xsl:value-of select="attrs/attr[@name='modpath']/string/@value" /></ModPath>
                  <Size><xsl:value-of select="attrs/attr[@name='size']/int/@value" /></Size>
                </Module>
              </xsl:for-each>
              <xsl:for-each select="attr[@name='configs']/attrs/attr">
                <Module>
                  <xsl:attribute name='id'>
                    <xsl:value-of select="attrs/attr[@name='configId']/string/@value" />
                  </xsl:attribute>
                  <xsl:attribute name='name'>
                    <xsl:value-of select="@name" />
                  </xsl:attribute>
                  <URL><xsl:value-of select="attrs/attr[@name='url']/string/@value" /></URL>
                  <Required>true</Required>
                  <MD5><xsl:value-of select="attrs/attr[@name='md5']/string/@value" /></MD5>
                  <Size><xsl:value-of select="attrs/attr[@name='size']/int/@value" /></Size>
                  <ModType inRoot="true">Extract</ModType>
                </Module>
              </xsl:for-each>
            </Server>
          </xsl:when>
          <xsl:otherwise>
            <Server autoConnect="false" launcherType='Vanilla' mainClass="cpw.mods.modlauncher.Launcher" serverClass="net.minecraftforge.server.ServerMain" newsUrl='https://madoka.brage.info/'>
              <xsl:attribute name='version'>
                <xsl:value-of select="attr[@name='minecraftVersion']/string/@value" />
              </xsl:attribute>
              <xsl:attribute name='serverAddress'>
                <xsl:value-of select="attr[@name='serverAddress']/string/@value" />
              </xsl:attribute>
              <xsl:attribute name='id'>
                <xsl:value-of select="attr[@name='serverId']/string/@value" />
              </xsl:attribute>
              <xsl:attribute name='name'>
                <xsl:value-of select="attr[@name='serverDesc']/string/@value" />
              </xsl:attribute>
              <xsl:attribute name='revision'>
                <xsl:value-of select="attr[@name='revision']/string/@value" />
              </xsl:attribute>
              <Loader type='Forge' loadOrder='0'>
                <xsl:attribute name='version'>
                  <xsl:value-of select="attr[@name='forgeVersion']/string/@value" />
                </xsl:attribute>
              </Loader>
              <xsl:for-each select="attr[@name='mods']/attrs/attr">
                <Module>
                  <xsl:attribute name='id'>
                    <xsl:value-of select="attrs/attr[@name='modId']/string/@value" />
                  </xsl:attribute>
                  <xsl:attribute name='name'>
                    <xsl:value-of select="attrs/attr[@name='name']/string/@value" />
                  </xsl:attribute>
                  <xsl:attribute name='side'>
                    <xsl:value-of select="attrs/attr[@name='side']/string/@value" />
                  </xsl:attribute>
                  <URL><xsl:value-of select="attrs/attr[@name='url']/string/@value" /></URL>
                  <Required>
                    <xsl:attribute name='isDefault'>
                      <xsl:value-of select="attrs/attr[@name='isDefault']/bool/@value" />
                    </xsl:attribute>
                    <xsl:value-of select="attrs/attr[@name='required']/bool/@value" />
                  </Required>
                  <MD5><xsl:value-of select="attrs/attr[@name='md5']/string/@value" /></MD5>
                  <ModType><xsl:value-of select="attrs/attr[@name='modtype']/string/@value" /></ModType>
                  <ModPath><xsl:value-of select="attrs/attr[@name='modpath']/string/@value" /></ModPath>
                  <Size><xsl:value-of select="attrs/attr[@name='size']/int/@value" /></Size>
                </Module>
              </xsl:for-each>
              <xsl:for-each select="attr[@name='configs']/attrs/attr">
                <Module>
                  <xsl:attribute name='id'>
                    <xsl:value-of select="attrs/attr[@name='configId']/string/@value" />
                  </xsl:attribute>
                  <xsl:attribute name='name'>
                    <xsl:value-of select="@name" />
                  </xsl:attribute>
                  <URL><xsl:value-of select="attrs/attr[@name='url']/string/@value" /></URL>
                  <Required>true</Required>
                  <MD5><xsl:value-of select="attrs/attr[@name='md5']/string/@value" /></MD5>
                  <Size><xsl:value-of select="attrs/attr[@name='size']/int/@value" /></Size>
                  <ModType inRoot="true">Extract</ModType>
                </Module>
              </xsl:for-each>
            </Server>
          </xsl:otherwise>
        </xsl:choose>
      </xsl:for-each>
    </ServerPack>
  </xsl:template>
</xsl:stylesheet>
