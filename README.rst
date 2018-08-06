.. _section-role-commonenv:

Role **commonenv**
================================================================================

Ansible role for maintaining common environment on all target systems.

* `Ansible Galaxy page <https://galaxy.ansible.com/honzamach/commonenv>`__
* `GitHub repository <https://github.com/honzamach/ansible-role-commonenv>`__
* `Travis CI page <https://travis-ci.org/honzamach/ansible-role-commonenv>`__


Description
--------------------------------------------------------------------------------

Main purpose of this role is to setup the environment on all servers to the liking
of main system administrator. It will perform following tasks:

* Configuration of */etc/apt/sources.list* file.
* Removal of unnecessary packages, that are present after clean installation.
* Installation of essential software, tools and utilities, that the administrator
  needs to be present on all his/her servers.
* Configuration of */root/.bashrc* resource script.
* Configuration of */root/.system-banner* script, that is called from */root/.bashrc*
  script.
* Configuration of global */etc/vim/vimrc* resource script.

.. note::

    This role supports the :ref:`template customization <section-overview-customize-templates>` feature.


Requirements
--------------------------------------------------------------------------------

This role does not have any special requirements.


Dependencies
--------------------------------------------------------------------------------

This role is not dependent on any other role.

No other roles have direct dependency on this role.


Managed files
--------------------------------------------------------------------------------

* ``/etc/apt/sources.list``
* ``/etc/vim/vimrc``
* ``/root/.bashrc``
* ``/root/.system-banner``


Internal variables
--------------------------------------------------------------------------------

.. envvar:: hm_commonenv__deb_force_update

    Force update of system package cache before installing any packages.

    * *Datatype:* ``bool``
    * *Default:* ``true``

.. envvar:: hm_commonenv__deb_mirror

    Debian mirror which will be used for installing the packages.

    * *Datatype:* ``str``
    * *Default:* ``ftp.cz.debian.org/debian/``

.. envvar:: hm_commonenv__deb_remove_packages

    List of Debian packages, that MUST NOT be present on target system. Any package
    on this list will be removed from target host.

    * *Datatype:* ``list of strings``
    * *Default:* (please see YAML file ``defaults/main.yml``)

.. envvar:: hm_commonenv__deb_install_packages

    List of Debian packages, that MUST be present on target system. Any package
    on this list will be installed on target host.

    * *Datatype:* ``list of strings``
    * *Default:* (please see YAML file ``defaults/main.yml``)


Usage and customization
--------------------------------------------------------------------------------

This role is (attempted to be) written according to the `Ansible best practices <https://docs.ansible.com/ansible/latest/user_guide/playbooks_best_practices.html>`__. The default implementation should fit most users,
however you may customize it by tweaking default variables and providing custom
templates.


Variable customizations
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Most of the usefull variables are defined in ``defaults/main.yml`` file, so they
can be easily overridden almost from `anywhere <https://docs.ansible.com/ansible/latest/user_guide/playbooks_variables.html#variable-precedence-where-should-i-put-a-variable>`__.


Template customizations
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

This roles uses *with_first_found* mechanism for all of its templates. If you do
not like anything about built-in template files you may provide your own custom
templates. For now please see the role tasks for list of all checked paths for
each of the template files.


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


Example Playbook
--------------------------------------------------------------------------------

Example content of inventory file ``inventory``::

    [servers-commonenv]
    localhost

Example content of role playbook file ``playbook.yml``::

    - hosts: servers-commonenv
      remote_user: root
      roles:
        - role: honzamach.commonenv
      tags:
        - role-commonenv

Example usage::

    ansible-playbook -i inventory playbook.yml


License
--------------------------------------------------------------------------------

MIT


Author Information
--------------------------------------------------------------------------------

Honza Mach <honza.mach.ml@gmail.com>
