# Generated by Django 3.0.6 on 2020-09-12 09:03

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('index', '0007_auto_20200910_1107'),
    ]

    operations = [
        migrations.AlterField(
            model_name='message',
            name='username',
            field=models.CharField(db_index=True, help_text='用户名', max_length=64, verbose_name='用户名'),
        ),
    ]