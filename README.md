# NetSpyGlass data source plugin for Grafana 

This data source enabled Grafana to query metrics collected and stored
by [NetSpyGlass](http://www.happygears.net) server.

NetSpyGlass is integrated network mapping and monitoring system that presents live monitoring 
data as series of animated network maps. NetSpyGlass discovers your network using SNMP,
builds a model that represents Layer2 connections and automatically configures itself to 
monitor all aspects of network devices and servers, striving to be useful “out of the box” 
with very little initial configuration and ongoing maintenance. 

Administrator can write Python scripts that run inside of the server
on every polling interval. These scripts operate with monitoring
data and can be used to calculate new metrics derived from the collected "raw" data,
for example various aggregates. Results produced by these scripts become
part of the general data pool and are available for graphing with
Grafana, as well as for alerts and reports.

NetSpyGlass requires little effort to set up and keep up with your network 
as it grows and can scale to thousands of devices and millions of metrics.


## Features

  - Flexible query editor with device, component and tags match
  - Support for the Graph and Table panels
  - Support for Dashboard template variables
  - With this plugin, Grafana makes queries directly to NetSpyGlass
    server to receive lists of available metrics, devices, components
    and tags. This means it is agnostic with respect to the time series
    database used by the NetSpyGlass server and can work with any of 
    them (rrd, graphite, InfluxDb, hbase)
  - 

## Templated dashboards support

Device name, component name or any tag defined in NetSpyGlass can be used
as template variable. For example, this can be used to build an interactive 
dashboard that can display information for a device you choose. Dashboard
makes special query to NetSpyGlass server to receive list of devices. Once
you choose the device, all panels in the dashboard switch to show data
collected from this device. Component names or tags can be used in a similar
way to build interactive dashboards.

## Installation

1. clone this git repository
2. run script `./tools/maketar.sh`. This script produces archive `netspyglass-datasource.tar`
3. Copy this archive to the server where Grafana runs and unpack it in 
the directory `/var/lib/grafana/plugins/`, then restart the server with command
`sudo service grafana-server restart`.
4. After the restart, NetSpyGlass should appear in the list of available
 data sources. If your NetSpyGlass server requires user authentication,
 add enable and configure access token. The token is set in NetSpyGlass
 configuration file `nw2.conf` using parameter key `api.accessTokens.grafana`
5. Click "Add" and then "Save and Test" to test communication with
 the server


 ## Developing

Dependencies: grafana grunt grunt-cli nodejs >= 6

1. clone this git repository
2. open root folder of the cloned repo
3. run command `npm install`
4. run command `grunt` - now you have new folder dist_dev in the project root
5. create symbolic link from dist_dev to grafana plugins folder
   for example `ln -s /home/users/developer/netspyglass-grafana/dist_dev/ /var/lib/grafana/plugins/`
6. restart your grafana instance

For development plugin run command `grunt watch` and now you can edit files in src folder.
If you want create production build and update dist folder please execute next command 

NODE_ENV=production grunt
 

## Screenshots

Data Source configuration:

![query editor screenshot](https://raw.githubusercontent.com/happygears/netspyglass-grafana/master/doc/screenshots/netspyglass_data_source.png)


Example of a graph query that matches metrics by tag "Role.Switch":

![query editor screenshot](https://raw.githubusercontent.com/happygears/netspyglass-grafana/master/doc/screenshots/graph_query_with_tag_match_annotated.png)


Building "top N" report in Grafana table panel (selects top 5):

![top N report](https://raw.githubusercontent.com/happygears/netspyglass-grafana/master/doc/screenshots/top_n_table_panel_editor_annotated.png)

## Tested with Grafana 4.1.1

(C) 2017 Happy Gears, Inc  www.happygears.net

Grafana plugin for NetSpyGlass is licensed under the Apache 2.0 License

# Change Log


### v2.0.0
## Tested with Grafana 4.1.1 - this is minimum required version

1. In this version, we completely changed the approach to getting data from the server, so this version is not compatible with the previous ones. The server API was changed to a SQL-like syntax. The query builder is implemented from scratch in a more modern form.


## Tested with Grafana 4.0.1
### v1.0.4

1. fixed regression caused by the switch to lodash 4.x. This bug broke time intervals "today", 
   "yesterday" and others like that.


### v 1.0.3
1. Fixed regression caused by "Grafana" bug [#6912](https://github.com/grafana/grafana/pull/6912) 
that break ability to build queries/fields.


### v 1.0.2

1. fixed bug that prevented the data source from properly fetching graph
data for graphs with fixed time intervals or time intervals in the past,
such as "yesterday" or "day before yesterday"
2. made it possible to use dashboard template variables in "ALIAS BY"
query field.

