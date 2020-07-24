.. _section-role-commonenv:

Role **commonenv**
================================================================================

* `Ansible Galaxy page <https://galaxy.ansible.com/honzamach/commonenv>`__
* `GitHub repository <https://github.com/honzamach/ansible-role-commonenv>`__
* `Travis CI page <https://travis-ci.org/honzamach/ansible-role-commonenv>`__

Main purpose of this role is to setup the environment on all servers to the liking
of the primary system administrator. Following tasks will be performed:

* Configuration of ``/etc/apt/sources.list`` file, to make sure you are using
  appropriate mirror server.
* Removal of unnecessary packages, that are present after clean installation.
  Perhaps you want your installation to be even more minimalistic, or you want
  to get rid of some default packages in favor some alternative, for example
  use different logging daemon or MTA.
* Installation of essential software, tools and utilities, that the administrator
  needs to be present on all his/her servers. If you have your favorite suite
  of tools, you can enforce them to be available on each of your servers.
* Configuration of ``/root/.bashrc`` resource script.
* Configuration of ``/root/.system-banner`` script, that is called from ``/root/.bashrc``
  script.
* Configuration of global ``/etc/vim/vimrc`` resource script.

**Table of Contents:**

* :ref:`section-role-commonenv-installation`
* :ref:`section-role-commonenv-dependencies`
* :ref:`section-role-commonenv-usage`
* :ref:`section-role-commonenv-variables`
* :ref:`section-role-commonenv-files`
* :ref:`section-role-commonenv-author`

This role is part of the `MSMS <https://github.com/honzamach/msms>`__ package.
Some common features are documented in its :ref:`manual <section-manual>`.


.. _section-role-commonenv-installation:

Installation
--------------------------------------------------------------------------------

To install the role `honzamach.commonenv <https://galaxy.ansible.com/honzamach/commonenv>`__
from `Ansible Galaxy <https://galaxy.ansible.com/>`__ please use variation of
following command::

    ansible-galaxy install honzamach.commonenv

To install the role directly from `GitHub <https://github.com>`__ by cloning the
`ansible-role-commonenv <https://github.com/honzamach/ansible-role-commonenv>`__
repository please use variation of following command::

    git clone https://github.com/honzamach/ansible-role-commonenv.git honzamach.commonenv

Currently the advantage of using direct Git cloning is the ability to easily update
the role when new version comes out.


.. _section-role-commonenv-dependencies:

Dependencies
--------------------------------------------------------------------------------

This role is not dependent on any other role.

Following roles have dependency on this role:

* :ref:`section-role-logserver` *[SOFT]*
* :ref:`section-role-mentat` *[SOFT]*
* :ref:`section-role-mentat-dev` *[SOFT]*
* :ref:`section-role-postgresql` *[SOFT]*
* :ref:`section-role-warden-client` *[SOFT]*


.. _section-role-commonenv-usage:

Usage
--------------------------------------------------------------------------------

Example content of inventory file ``inventory``::

    [servers]
    your-server

    [servers_commonenv]
    your-server

Example content of role playbook file ``role_playbook.yml``::

    - hosts: servers_commonenv
      remote_user: root
      roles:
        - role: honzamach.commonenv
      tags:
        - role-commonenv

Example usage::

    # Run everything:
    ansible-playbook --ask-vault-pass --inventory inventory role_playbook.yml

    # Force update of system package cache before installing any packages:
    ansible-playbook --ask-vault-pass --inventory inventory role_playbook.yml --extra-vars '{"hm_commonenv__pkgcache_force_update":true}'


.. _section-role-commonenv-variables:

Configuration variables
--------------------------------------------------------------------------------


Internal role variables
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. envvar:: hm_commonenv__pkgcache_force_update

    Force update of system package cache before installing any packages.

    * *Datatype:* ``bool``
    * *Default:* ``false``

.. envvar:: hm_commonenv__manage_sources_list

    Let the role manage contents of ``/etc/apt/sources.list`` file.

    * *Datatype:* ``bool``
    * *Default:* ``true``

.. envvar:: hm_commonenv__deb_mirror

    Debian mirror which will be used for installing packages.

    * *Datatype:* ``str``
    * *Default:* ``ftp.cz.debian.org/debian/``

.. envvar:: hm_commonenv__remove_packages

    List of packages defined separately for each linux distribution and package manager,
    that MUST NOT be present on target system. Any package on this list will be removed
    from target host. This role currently recognizes only ``apt`` for ``debian``.

    * *Datatype:* ``dict``
    * *Default:* (please see YAML file ``defaults/main.yml``)
    * *Example:*

    .. code-block:: yaml

        hm_commonenv__remove_packages:
          debian:
            apt:
              - needrestart
              - ...

.. envvar:: hm_commonenv__install_packages

    List of packages defined separately for each linux distribution and package manager,
    that MUST be present on target system. Any package on this list will be installed on
    target host. This role currently recognizes only ``apt`` for ``debian``.

    * *Datatype:* ``dict``
    * *Default:* (please see YAML file ``defaults/main.yml``)
    * *Example:*

    .. code-block:: yaml

        hm_commonenv__install_packages:
          debian:
            apt:
              - apt
              - ...


Built-in Ansible variables
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

:envvar:`ansible_lsb['codename']`

    Linux distribution codename. It is used to generate correct APT repository URL
    and for :ref:`template customizations <section-overview-role-customize-templates>`.


.. _section-role-commonenv-files:

Managed files
--------------------------------------------------------------------------------

.. note::

    This role supports the :ref:`template customization <section-overview-role-customize-templates>`
    feature.

This role manages content of following files on target system:

* ``/etc/apt/sources.list`` *[TEMPLATE]*

  Customizable with following templates::

    ``inventory/host_files/{{ inventory_hostname }}/honzamach.commonenv/sources.list.j2``
    ``inventory/group_files/servers_{{ msms_server_type }}/honzamach.commonenv/sources.list.{{ ansible_lsb['codename'] }}.j2``
    ``inventory/group_files/servers/honzamach.commonenv/sources.list.{{ ansible_lsb['codename'] }}.j2``

* ``/etc/vim/vimrc`` *[TEMPLATE]*

  Customizable with following templates::

    ``inventory/host_files/{{ inventory_hostname }}/honzamach.commonenv/vimrc.j2``
    ``inventory/group_files/servers_{{ msms_server_type }}/honzamach.commonenv/vimrc.{{ ansible_lsb['codename'] }}.j2``
    ``inventory/group_files/servers_{{ msms_server_type }}/honzamach.commonenv/vimrc.j2``
    ``inventory/group_files/servers/honzamach.commonenv/vimrc.{{ ansible_lsb['codename'] }}.j2``
    ``inventory/group_files/servers/honzamach.commonenv/vimrc.j2``

* ``/root/.bashrc`` *[TEMPLATE]*

  Customizable with following templates::

    ``inventory/host_files/{{ inventory_hostname }}/honzamach.commonenv/bashrc.j2``
    ``inventory/group_files/servers_{{ msms_server_type }}/honzamach.commonenv/bashrc.{{ ansible_lsb['codename'] }}.j2``
    ``inventory/group_files/servers_{{ msms_server_type }}/honzamach.commonenv/bashrc.j2``
    ``inventory/group_files/servers/honzamach.commonenv/bashrc.{{ ansible_lsb['codename'] }}.j2``
    ``inventory/group_files/servers/honzamach.commonenv/bashrc.j2``

* ``/root/.system-banner`` *[TEMPLATE]*

  Customizable with following templates::

    ``inventory/host_files/{{ inventory_hostname }}/honzamach.commonenv/system-banner.j2``
    ``inventory/group_files/servers_{{ msms_server_type }}/honzamach.commonenv/system-banner.{{ ansible_lsb['codename'] }}.j2``
    ``inventory/group_files/servers_{{ msms_server_type }}/honzamach.commonenv/system-banner.j2``
    ``inventory/group_files/servers/honzamach.commonenv/system-banner.{{ ansible_lsb['codename'] }}.j2``
    ``inventory/group_files/servers/honzamach.commonenv/system-banner.j2``


.. _section-role-commonenv-author:

Author and license
--------------------------------------------------------------------------------

| *Copyright:* (C) since 2019 Honza Mach <honza.mach.ml@gmail.com>
| *Author:* Honza Mach <honza.mach.ml@gmail.com>
| Use of this role is governed by the MIT license, see LICENSE file.
|
