# -*- coding: utf-8 -*-
from __future__ import unicode_literals

from django.db import models, migrations


class Migration(migrations.Migration):

    dependencies = [
        ('taiga_contrib_dingtalk', '0001_initial'),
    ]

    operations = [
        migrations.AddField(
            model_name='dingtalkhook',
            name='channel',
            field=models.CharField(max_length=200, verbose_name='Channel', null=True, blank=True),
            preserve_default=True,
        ),
    ]
