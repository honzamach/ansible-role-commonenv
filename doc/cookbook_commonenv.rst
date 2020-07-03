.. _section-cookbook-roles-cleanup:

Host common environment setup
================================================================================


.. _section-cookbook-roles-commonenv-custsrclist:

Custom /etc/sources.list file
--------------------------------------------------------------------------------

The role :ref:`commonenv <section-role-commonenv>` provides default version of
customized ``/root/.bashrc`` file. Should you need to customize it for your
particular needs, you may place your own version in one of the following places
to override the default:

* ``inventory/host_files/{{ inventory_hostname }}/honzamach.commonenv/sources.list.j2``
* ``inventory/group_files/servers_{{ msms_server_type }}/honzamach.commonenv/sources.list.{{ ansible_lsb['codename'] }}.j2``
* ``inventory/group_files/servers/honzamach.commonenv/sources.list.{{ ansible_lsb['codename'] }}.j2``

As you can see, you may perform override for particular host, for all servers
of given type or all servers.

Then execute the role::

    apbf role_commonenv.yml


.. _section-cookbook-roles-commonenv-custbashrc:

Custom .bashrc file
--------------------------------------------------------------------------------

The role :ref:`commonenv <section-role-commonenv>` provides default version of
customized ``/root/.bashrc`` file. Should you need to customize it for your
particular needs, you may place your own version in one of the following places
to override the default:

* ``inventory/host_files/{{ inventory_hostname }}/honzamach.commonenv/bashrc.j2``
* ``inventory/group_files/servers_{{ msms_server_type }}/honzamach.commonenv/bashrc.{{ ansible_lsb['codename'] }}.j2``
* ``inventory/group_files/servers_{{ msms_server_type }}/honzamach.commonenv/bashrc.j2``
* ``inventory/group_files/servers/honzamach.commonenv/bashrc.{{ ansible_lsb['codename'] }}.j2``
* ``inventory/group_files/servers/honzamach.commonenv/bashrc.j2``

Then execute the role::

    apbf role_commonenv.yml
