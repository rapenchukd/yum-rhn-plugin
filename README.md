yum-rhn-plugin Cookbook
=================
Cookbook for installing and configuring yum-rhn-plugin for use with RHN, Satellite, or Spacewalk

# Supported platforms
- EL 5.X platforms
- EL 6.X platforms
- EL 7.X platforms

# Usage

Put `depends 'yum-rhn-plugin'` in your metadata.rb

Out of the box this cookbook will configure the standard [main] rhn channel after installation of yum plugin,
additional channels may be added via data bags.

## Attributes

['yum-rhn']['source'] - Set to specify location to obtain rpm from non yum-configured source. Leaving nil will install via yum.

['yum-rhn']['data_bag'] - Set to specify data bag to pull items as arrays for additional channels to add to plugin config

['yum-rhn']['main']['enabled'] - 1/0 bit to enable/disable main rhn channel

['yum-rhn']['main']['gpg-check'] - 1/0 bit to enable/disable GPG checks for main channel

## Data Bag Items

For each channel you wish to configure, add a data bag item like so:

```json
{
        "id": "channel1",
        "channel": "some-channel",
        "enabled": "1",
        "gpg-check: "0"
}
```
will create:
```sh
[some-channel]
enabled=1
gpg-check=0
```

## Recipes

::default - Installs yum-rhn-plugin then includes ::config

::config - Configures yum-rhn plugin

## Author

Author:: Drew Rapenchuk (rapenchuk@linux.com)
