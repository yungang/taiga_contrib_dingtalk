#!/usr/bin/env python
# -*- coding: utf-8 -*-

import versiontools_support
from setuptools import setup, find_packages

setup(
    name = 'taiga-contrib-dingtalk',
    version = ":versiontools:taiga_contrib_dingtalk:",
    description = "The Taiga plugin for dingtalk integration",
    long_description = "",
    keywords = 'taiga, dingtalk, integration',
    author = 'Zang Yungang',
    author_email = 'zang_yungang@gowild.cn',
    url = 'https://github.com/yungang/taiga_contrib_dingtalk.git',
    license = 'AGPL',
    include_package_data = True,
    packages = find_packages(),
    install_requires=[],
    setup_requires = [
        'versiontools >= 1.9',
    ],
    classifiers = [
        "Programming Language :: Python",
        'Development Status :: 1 - Beta',
        'Framework :: Django',
        'Intended Audience :: Developers',
        'License :: OSI Approved :: GNU Affero General Public License v3',
        'Operating System :: OS Independent',
        'Topic :: Internet :: WWW/HTTP',
    ]
)
