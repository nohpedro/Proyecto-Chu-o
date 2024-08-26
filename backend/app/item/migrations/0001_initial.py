# Generated by Django 3.2.25 on 2024-05-27 21:44

from django.db import migrations, models


class Migration(migrations.Migration):

    initial = True

    dependencies = [
    ]

    operations = [
        migrations.CreateModel(
            name='Brand',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('marca', models.CharField(max_length=100)),
            ],
        ),
        migrations.CreateModel(
            name='Category',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('nombre', models.CharField(max_length=100)),
                ('description', models.TextField(blank=True)),
            ],
        ),
        migrations.CreateModel(
            name='Item',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('nombre', models.CharField(max_length=255)),
                ('description', models.TextField(blank=True)),
                ('link', models.CharField(blank=True, max_length=255)),
                ('serial_number', models.CharField(blank=True, max_length=100)),
                ('quantity', models.PositiveIntegerField(default=1)),
                ('categories', models.ManyToManyField(related_name='items', to='item.Category')),
                ('marca', models.ManyToManyField(to='item.Brand')),
            ],
        ),
    ]
