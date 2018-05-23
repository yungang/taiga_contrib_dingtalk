# -*- coding: utf-8 -*-
# Generated by Django 1.9.2 on 2016-09-14 14:20
from __future__ import unicode_literals

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('taiga_contrib_dingtalk', '0003_auto_20150923_1620'),
    ]

    operations = [
        migrations.AddField(
            model_name='dingtalkhook',
            name='notify_epic_change',
            field=models.BooleanField(default=True),
        ),
        migrations.AddField(
            model_name='dingtalkhook',
            name='notify_epic_create',
            field=models.BooleanField(default=True),
        ),
        migrations.AddField(
            model_name='dingtalkhook',
            name='notify_epic_delete',
            field=models.BooleanField(default=True),
        ),
        migrations.AddField(
            model_name='dingtalkhook',
            name='notify_relateduserstory_create',
            field=models.BooleanField(default=True),
        ),
        migrations.AddField(
            model_name='dingtalkhook',
            name='notify_relateduserstory_delete',
            field=models.BooleanField(default=True),
        ),
    ]