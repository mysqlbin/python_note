# Generated by Django 3.1.3 on 2021-01-18 01:47

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('meta_manage', '0006_mysqlschema_instance_name'),
    ]

    operations = [
        migrations.AlterField(
            model_name='mysqlschema',
            name='instance_name',
            field=models.CharField(default=None, max_length=128, null=True),
        ),
    ]