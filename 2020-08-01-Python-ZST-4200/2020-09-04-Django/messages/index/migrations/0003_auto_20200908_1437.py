# Generated by Django 3.0.6 on 2020-09-08 06:37

from django.db import migrations


class Migration(migrations.Migration):

    dependencies = [
        ('index', '0002_article_publication'),
    ]

    operations = [
        migrations.DeleteModel(
            name='Message',
        ),
        migrations.DeleteModel(
            name='Reporter',
        ),
    ]