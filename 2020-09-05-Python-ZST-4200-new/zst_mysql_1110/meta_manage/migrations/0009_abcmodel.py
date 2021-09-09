# Generated by Django 3.1.3 on 2021-01-18 08:33

from django.db import migrations, models
import django.utils.timezone


class Migration(migrations.Migration):

    dependencies = [
        ('meta_manage', '0008_auto_20210118_1627'),
    ]

    operations = [
        migrations.CreateModel(
            name='AbcModel',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('name', models.CharField(max_length=30)),
                ('memory', models.CharField(max_length=30)),
                ('cpu', models.CharField(max_length=30)),
                ('gmt_create', models.DateTimeField(default=django.utils.timezone.now)),
            ],
            options={
                'db_table': 'mysql_abc',
            },
        ),
    ]
