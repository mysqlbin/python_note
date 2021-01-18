# Generated by Django 3.1.3 on 2021-01-18 17:17

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('meta_manage', '0009_abcmodel'),
    ]

    operations = [
        migrations.CreateModel(
            name='EfgModel',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('name', models.CharField(max_length=30)),
                ('memory', models.CharField(max_length=30)),
                ('cpu', models.CharField(max_length=30)),
                ('gmt_create', models.DateTimeField(auto_now_add=True, null=True)),
            ],
            options={
                'db_table': 'mysql_efg',
            },
        ),
    ]