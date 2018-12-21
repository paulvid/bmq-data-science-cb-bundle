# BMQ Data Science Bundle

<div align="center">
<img src="https://raw.githubusercontent.com/paulvid/bmq-data-science-cb-bundle/master/BMQ_LOGO.png">
</div>

## Description

This bundle contains blueprints and recipes necessary to setup a short lasting cluster training ML pipeline for the Beast Mode Quotient application detailed here: https://community.hortonworks.com/content/kbentry/226140/beast-mode-quotient-using-hybrid-cloud-architectur.html


## How-To

* Preparation
    * Setup an instance of Cloudbreak with the right credentials
    * Change the tp-bmq-data-science.json to reflect these credentials
    * Add the Blueprint bd-bmq-data-science.json to your CB instance
    * Add the pre-ambari recipe pras-bmq-data-science.sh to your instance
    * Install CB cli
    * Change launch-bmq-ephemeral-cluster.sh and terminate-bmq-ephemeral-cluster.sh to reflect your CB location, username, password as well as the location of the cli

* Launch an ephemeral cluster
    * Run launch-bmq-ephemeral-cluster.sh

* Terminate all launched clusters
    * Run terminate-bmq-ephemeral-cluster.sh


## Versions

* Cloudbreak 2.8.0
* HDP 3.1

## Authors

* **Paul Vidal** - *Initial work* - [LinkedIn](https://www.linkedin.com/in/paulvid/)