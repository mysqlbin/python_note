# Generated by Django 3.1.3 on 2021-01-13 03:40

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('meta_manage', '0003_schematest3'),
    ]

    operations = [
        migrations.CreateModel(
            name='SchemaTest5',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('schema', models.CharField(max_length=128, verbose_name='库名')),
                ('db_type', models.CharField(choices=[('MySQL', 'mysql'), ('SQLServer', 'sqlserver'), ('Redis', 'redis')], max_length=128, verbose_name='数据库类型')),
                ('ip', models.GenericIPAddressField(verbose_name='ip')),
                ('port', models.IntegerField(verbose_name='端口')),
            ],
        ),
    ]