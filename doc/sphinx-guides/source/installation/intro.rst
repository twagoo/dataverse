============
Introduction
============

Welcome! Thanks for installing `The Dataverse Project <https://dataverse.org>`_!

.. contents:: |toctitle|
	:local:

Quick Links
-----------

If you are installing the Dataverse Software for the first time, please proceed to the :doc:`prep` section.

Jump ahead to :doc:`config` or :doc:`upgrading` for an existing Dataverse installation.

Intended Audience
-----------------

This guide is intended primarily for sysadmins who are installing, configuring, and upgrading a Dataverse installation. 

Sysadmins are expected to be comfortable using standard Linux commands, issuing ``curl`` commands, and running SQL scripts.

Related Guides
--------------

Many "admin" functions can be performed by Dataverse installation users themselves (non-superusers) as documented in the :doc:`/user/index` and that guide is a good introduction to the features of the Dataverse Software from an end user perspective.

If you are a sysadmin who likes to code, you may find the :doc:`/api/index` useful, and you may want to consider improving the installation script or hacking on the community-lead configuration management options mentioned in the :doc:`prep` section. If you **really** like to code and want to help with the Dataverse Software code, please check out the :doc:`/developers/index`!

.. _support:

Getting Help
------------

To get help installing or configuring a Dataverse installation, please try one or more of:

- posting to the `dataverse-community <https://groups.google.com/forum/#!forum/dataverse-community>`_ Google Group.
- asking at https://chat.dataverse.org
- emailing support@dataverse.org to open a private ticket at https://help.hmdc.harvard.edu

Information to Send to Support When Installation Fails
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

If you've encountered a problem installing Dataverse and are ready to ask for help, please consider sending along the following information so that the Dataverse team and community can more easily assist you.

- Version of Dataverse you are trying to install.
- Operating system (usually a Linux distribution) and version.
- Output from the installer (STDOUT, STDERR).
- The ``scripts/api/setup-all.*.log`` files left behind by the installer.
- The ``server.log`` file from Payara (by default at ``/usr/local/payara6/glassfish/domains/domain1/logs/server.log``).

Improving this Guide
--------------------

If you spot a typo in this guide or would like to suggest an improvement, please find the appropriate file in https://github.com/IQSS/dataverse/tree/develop/doc/sphinx-guides/source/installation and send a pull request as explained in the :doc:`/developers/documentation` section of the Developer Guide. You are also welcome to simply open an issue at https://github.com/IQSS/dataverse/issues to describe the problem with this guide.

Next is the :doc:`prep` section.
